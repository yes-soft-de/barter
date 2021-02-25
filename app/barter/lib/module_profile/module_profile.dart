import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:barter/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ProfileModule {
  final ActivityScreen activityScreen;
  final EditProfileScreen editProfileScreen;

  ProfileModule(this.activityScreen, this.editProfileScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ProfileRoutes.PROFILE_SCREEN: (context) => activityScreen,
      ProfileRoutes.EDIT_PROFILE_SCREEN: (context) => editProfileScreen,
    };
  }
}
