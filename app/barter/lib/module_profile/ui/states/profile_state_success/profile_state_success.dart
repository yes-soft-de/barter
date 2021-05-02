
import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:barter/module_services/services_routes.dart';
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
          Text('Save Success'),//S.of(context).saveSuccess),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context,ServicesRoutes.ROUTE_ADD_SERVICE, (route) => false);

              // Navigator.pushNamedAndRemoveUntil(context, HomeRoutes.HOME_ROUTE, (route) => false);
            },
            child: Text('Next'),//S.of(context).next),
          ),
        ],
      ),
    );
  }
}
