import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_swap/ui/state/swap_state.dart';
import 'package:barter/module_swap/ui/widget/swap_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwapStateLoaded extends SwapState {
  List<SwapModel> swaps;

  SwapStateLoaded(SwapScreen screen, this.swaps) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: swaps.map((e) => SwapCard(e)).toList(),
    );
  }
}
