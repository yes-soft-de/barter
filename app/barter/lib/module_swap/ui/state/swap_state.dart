
import 'package:flutter/material.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';

abstract class SwapState {
    final SwapScreen screen;
    SwapState(this.screen);

    Widget getUI(BuildContext context);
}