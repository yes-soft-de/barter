import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:flutter/material.dart';

class LoginStateSuccess extends LoginState {
  LoginStateSuccess(LoginScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlutterLogo(),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          padding: EdgeInsets.all(16),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileRoutes.EDIT_PROFILE_SCREEN);
            });
          },
          child: Text('Welcome to Barter'),
        )
      ],
    );
  }
}
