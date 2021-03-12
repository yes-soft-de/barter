import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProfileStateLoaded extends UserProfileState {
  UserProfileStateLoaded(UserProfileScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column();
  }

}