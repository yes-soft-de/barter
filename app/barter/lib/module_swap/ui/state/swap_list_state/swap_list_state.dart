import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class SwapListState {
  final SwapsScreen screen;

  SwapListState(this.screen);

  Widget getUI(BuildContext context);
}