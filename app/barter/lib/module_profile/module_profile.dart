import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ProfileModule extends YesModule {
  final EditProfileScreen editProfileScreen;
  final UserProfileScreen userProfileScreen;

  ProfileModule(this.editProfileScreen, this.userProfileScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ProfileRoutes.EDIT_PROFILE_SCREEN: (context) => editProfileScreen,
      ProfileRoutes.PROFILE_SCREEN: (context) => userProfileScreen,
    };
  }
}
