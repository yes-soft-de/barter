import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_profile/state_manager/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_loading.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class UserProfileScreen extends StatefulWidget {
  final UserProfileStateManager _stateManager;
  UserProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileState _currentState;
  @override
  void initState() {
    widget._stateManager.stateSubject.stream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == null) {
      var param = ModalRoute.of(context).settings.arguments;
      widget._stateManager.getUserInfoByServiceId(widget, param);
    }
    _currentState ??= UserProfileStateLoading(widget);
    return Scaffold(
      body: _currentState.getUI(context),
    );
  }
}
