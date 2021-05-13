import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:flutter/material.dart';

abstract class UpdateSwapState {
  final UpdateSwapScreen screen;
  UpdateSwapState(this.screen);

  Widget getUI(BuildContext context);
}
