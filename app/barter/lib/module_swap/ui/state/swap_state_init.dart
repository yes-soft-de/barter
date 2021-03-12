import 'package:flutter/material.dart';
import 'swap_state.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';

class SwapStateInit extends SwapState {
  SwapStateInit(SwapScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Text('Hello!');
  }
}
