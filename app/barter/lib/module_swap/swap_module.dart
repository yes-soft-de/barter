import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_swap/swap_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class swapModule extends YesModule {
  swapModule();

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SwapRoutes.SWAP_BY_ID_ROUTE: (context) => Scaffold(),
    };
  }
}
