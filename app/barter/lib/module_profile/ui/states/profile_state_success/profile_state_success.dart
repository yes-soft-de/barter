import 'package:barter/generated/l10n.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:barter/module_splash/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileStateSaveSuccess extends ProfileState {
  ProfileStateSaveSuccess(EditProfileScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.solidHeart,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
          Text(S.of(context).saveSuccess),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SplashRoutes.SPLASH_SCREEN);
            },
            child: Text(S.of(context).next),
          ),
        ],
      ),
    );
  }
}
