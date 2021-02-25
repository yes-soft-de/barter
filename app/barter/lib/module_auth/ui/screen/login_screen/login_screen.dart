import 'dart:async';

import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  void loginCaptain(String phoneNumber) {
    _stateManager.loginCaptain(phoneNumber, this);
  }

  void loginOwner(String email, String password) {
    _stateManager.loginOwner(email, password, this);
  }

  void confirmCaptainSMS(String smsCode) {
    _stateManager.confirmSMSCode(smsCode, this);
  }

  void retryPhone() {
    _stateManager.retryPhone(this);
  }

  void refresh(LoginState state) {
    _stateManager.refresh(state);
  }

  void loginViaGoogle() {
    _stateManager.loginViaGoogle(this);
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRole currentUserRole;

  LoginState _currentStates;

  StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _currentStates ??= LoginStateInit(widget);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _currentStates.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }
}
