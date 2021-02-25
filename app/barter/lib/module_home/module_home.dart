import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_home/ui/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeModule extends YesModule {
  final HomeScreen _screen;
  HomeModule(this._screen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      HomeRoutes.HOME_ROUTE: (context) => _screen,
    };
  }
}
