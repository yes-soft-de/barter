import 'package:flutter/material.dart';
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';

abstract class CreateSwapState {
  final CreateSwapScreen screen;
  CreateSwapState(this.screen);

  Widget getUI(BuildContext context);
}
