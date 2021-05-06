import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwapListStateLoading extends SwapListState {
  SwapListStateLoading(SwapsScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}