import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/state_manager/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class EditProfileScreen extends StatefulWidget {
  final EditProfileStateManager _stateManager;
  EditProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  List<ProfileState> states = [];

  void saveProfile(ProfileRequest request) {
    widget._stateManager.submitProfile(this, request);
  }

  void moveToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
    });
  }

  void uploadImage(ProfileRequest request, services) {
    widget._stateManager.uploadImage(this, request, services);
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      states.add(event);
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getProfile(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (states.isEmpty) {
      states.add(ProfileStateLoading(this));
    }
    return Scaffold(
      body: SafeArea(child: states.last.getUI(context)),
    );
  }
}