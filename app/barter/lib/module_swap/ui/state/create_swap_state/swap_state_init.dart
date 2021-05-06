import 'package:flutter/material.dart';
import 'swap_state.dart';
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';

class SwapStateInit extends CreateSwapState {
  SwapStateInit(CreateSwapScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
