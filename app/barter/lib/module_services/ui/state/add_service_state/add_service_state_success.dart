import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:barter/module_profile/ui/states/profile_state_success/profile_state_success.dart';
import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddServiceStateSuccess extends AddServiceState {
  AddServiceStateSuccess(AddServiceScreen screen) : super(screen);

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
          Navigator.pushNamedAndRemoveUntil(context, HomeRoutes.HOME_ROUTE,(r)=>false );
        //  Navigator.of(context).pop();
        },
      ),
    ));
  }
}