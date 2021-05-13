import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_swap/swap_routes.dart';
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';
import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SwapModule extends YesModule {
  final SwapsScreen _swapsScreen;
  final CreateSwapScreen _createSwapScreen;
  final UpdateSwapScreen _updateSwapScreen;
  SwapModule(this._swapsScreen, this._createSwapScreen, this._updateSwapScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SwapRoutes.SWAPS_ROUTE: (context) => _swapsScreen,
      SwapRoutes.CREATE_SWAP_ROUTE: (context) => _createSwapScreen,
      SwapRoutes.UPDATE_SWAP_ROUTE: (context) => _updateSwapScreen
    };
  }
}
