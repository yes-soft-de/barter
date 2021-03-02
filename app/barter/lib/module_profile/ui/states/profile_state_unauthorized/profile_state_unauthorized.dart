import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateUnauthorized extends ProfileState {
  ProfileStateUnauthorized(EditProfileScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
            },
            child: Text('Please Login', textAlign: TextAlign.center,),
          ),
        )
      ],
    );
  }
}
