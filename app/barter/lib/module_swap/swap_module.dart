import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_swap/swap_routes.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SwapModule extends YesModule {
  final SwapScreen _swapScreen;
  SwapModule(this._swapScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SwapRoutes.SWAP_BY_ID_ROUTE: (context) => _swapScreen,
    };
  }
}
