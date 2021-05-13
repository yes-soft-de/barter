import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state.dart';
import 'package:barter/module_swap/ui/widget/swap_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwapListStateLoaded extends SwapListState {
  final List<SwapModel> swaps;

  SwapListStateLoaded(SwapsScreen screen, this.swaps) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _getSwapCard()),
        ),
      ),
    );
  }

  List<Widget> _getSwapCard() {
    var cards = <Widget>[];
    swaps.forEach((swap) {
      cards.add(SwapCard(SwapModel(
          id: swap.id,
          userOneName: swap.userOneName,
          userTowName: swap.userTowName,
          userOneImage: swap.userOneImage,
          userTowImage: swap.userTowImage,
          accepted: swap.accepted,
          chatRoomId: swap.chatRoomId,
          status: swap.status)));
    });
    return cards;
  }
}
