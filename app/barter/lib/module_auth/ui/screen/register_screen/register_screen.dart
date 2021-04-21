import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:barter/module_auth/presistance/auth_prefs_helper.dart';
import 'package:barter/module_auth/repository/auth/auth_repository.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:barter/module_auth/ui/states/register_states/register_state.dart';
import 'package:barter/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:barter/module_init/init_routes.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/module_profile.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/repository/profile/profile.repository.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:barter/module_profile/state_manager/edit_profile.dart';
import 'package:barter/module_profile/state_manager/user_profile.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_services/repository/services_repository.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_upload/manager/upload_manager/upload_manager.dart';
import 'package:barter/module_upload/repository/upload_repository/upload_repository.dart';
import 'package:barter/module_upload/service/image_upload/image_upload_service.dart';
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

  // void registerUser(String phoneNumber) {
  //   currentUserRole = UserRole.ROLE_FREELANCE;
  //   widget._stateManager.registerCaptain(phoneNumber, this);
  // }

  void registerUser(String email, String username, String password) {
    widget._stateManager.registerUser(email, username, password, this);
  }

  void registerCompany(String email, String username, String password) {
    currentUserRole = UserRole.ROLE_COMPANY;
    widget._stateManager.registerCompany(email, username, password, this);
  }

  void confirmCaptainSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_USER;
    widget._stateManager.confirmCaptainCode(smsCode);
  }

  void retryPhone() {
    currentUserRole = UserRole.ROLE_USER;
    _currentState = RegisterStateInit(this);
  }

  void moveToNext() {


    //Navigator.pushNamed(context, routeName);
    
  }
}
