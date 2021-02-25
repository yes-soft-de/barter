import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SplashScreen extends StatelessWidget {
  final AuthService _authService;
  final ProfileService _profileService;

  SplashScreen(
    this._authService,
    this._profileService,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }

  Future<String> _getNextRoute() async {
    return AuthorizationRoutes.LOGIN_SCREEN;
  }
}
