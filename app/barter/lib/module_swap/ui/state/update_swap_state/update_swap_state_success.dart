import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateSwapStateSuccess extends UpdateSwapState {
  UpdateSwapStateSuccess(UpdateSwapScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeRoutes.HOME_ROUTE, (r) => false);
          //  Navigator.of(context).pop();
        },
      ),
    ));
  }
}
