import 'package:barter/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

abstract class LoginState {
  final LoginScreen screen;
  LoginState(this.screen);

  Widget getUI(BuildContext context);
}
