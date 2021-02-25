import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state.dart';
import 'package:barter/module_auth/ui/widget/google_login/google_login.dart';
import 'package:flutter/material.dart';

class LoginStateInit extends LoginState {
  UserRole userType = UserRole.ROLE_OWNER;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);

  LoginStateInit(LoginScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GoogleLoginWidget(
          onGoogleLoginRequested: () {
            screen.loginViaGoogle();
          },
        ),
      ],
    ));
  }
}
