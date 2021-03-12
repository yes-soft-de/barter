import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:barter/module_auth/ui/states/register_states/register_state.dart';
import 'package:barter/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:barter/module_init/init_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class RegisterScreen extends StatefulWidget {
  final RegisterStateManager _stateManager;

  RegisterScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterState _currentState;
  UserRole currentUserRole;

  @override
  void initState() {
    super.initState();

    _currentState = RegisterStateInit(this);
    widget._stateManager.stateStream.listen((event) {
      if (this.mounted) {
        setState(() {
          _currentState = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _currentState.getUI(context),
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void registerCaptain(String phoneNumber) {
    currentUserRole = UserRole.ROLE_FREELANCE;
    widget._stateManager.registerCaptain(phoneNumber, this);
  }

  void registerOwner(String email, String username, String password) {
    currentUserRole = UserRole.ROLE_COMPANY;
    widget._stateManager.registerOwner(email, username, password, this);
  }

  void confirmCaptainSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_FREELANCE;
    widget._stateManager.confirmCaptainCode(smsCode);
  }

  void retryPhone() {
    currentUserRole = UserRole.ROLE_FREELANCE;
    _currentState = RegisterStateInit(this);
  }

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        InitAccountRoutes.INIT_ACCOUNT_SCREEN, (r) => false);
  }
}