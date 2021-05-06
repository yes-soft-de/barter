import 'package:barter/module_services/model/category_model.dart';
import 'package:barter/module_services/request/edit_service_request.dart';
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:barter/module_services/ui/widget/edit_service_form.dart';
import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/request/update_swap_request.dart';
import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state.dart';
import 'package:barter/module_swap/ui/widget/Update_swap_form.dart';
import 'package:barter/module_swap/ui/widget/swap_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateSwapStateGotSwap extends UpdateSwapState {
  final UpdateSwapRequest _request;
  final List<SwapItemsModel> myItems;
  final List<SwapItemsModel> targetItems;

  UpdateSwapStateGotSwap(UpdateSwapScreen screen,this._request, {this.myItems,this.targetItems}) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return UpdateSwapForm(
      request: _request,
      myItems: myItems,
      targetItems:targetItems,
      onSwapUpdate: (swap) {
        screen.updateSwap(swap);
      },
    );
  }
}
