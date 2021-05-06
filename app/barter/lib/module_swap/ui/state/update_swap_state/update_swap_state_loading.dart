import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state.dart';
import 'package:flutter/material.dart';

import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';

class SwapStateLoading extends UpdateSwapState {
  SwapStateLoading(UpdateSwapScreen screen) : super(screen);

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