import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state.dart';
import 'package:barter/module_swap/ui/widget/swap_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateSwapStateItemsAdded extends CreateSwapState {
  final String serviceId;
  final List<SwapItemsModel> myItems;
  final List<SwapItemsModel> targetItems;
  CreateSwapStateItemsAdded(CreateSwapScreen screen,
      {this.serviceId, this.myItems, this.targetItems})
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SwapForm(
      serviceId: serviceId,
      myItems: myItems,
      targetItems: targetItems,
      onSwapAdd: (swap) {
        screen.addSwap(swap);
      },
    );
  }
}
