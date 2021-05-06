
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwapListStateError extends SwapListState {
  final String error;
  SwapListStateError(SwapsScreen screen, this.error) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text('${error}')),
      ],
    );
  }
}