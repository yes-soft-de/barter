import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_splash/splash_routes.dart';
import 'package:barter/module_splash/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SplashModule extends YesModule {
  SplashScreen _splash;
  SplashModule(this._splash);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SplashRoutes.SPLASH_SCREEN: (context) => _splash,
    };
  }
}
