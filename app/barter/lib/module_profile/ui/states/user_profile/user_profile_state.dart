import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:flutter/material.dart';

abstract class UserProfileState {
  final UserProfileScreen screen;
  UserProfileState(this.screen);

  Widget getUI(BuildContext context);
}