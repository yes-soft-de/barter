import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_init/init_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountModule extends YesModule {
  InitAccountModule();

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {};
  }
}
