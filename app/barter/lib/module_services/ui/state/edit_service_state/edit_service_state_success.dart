import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'edit_service_state.dart';

class EditServiceStateSuccess extends EditServiceState {
  EditServiceStateSuccess(EditServiceScreen screen) : super(screen);

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
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeRoutes.HOME_ROUTE, (r) => false);
        },
      ),
    ));
  }
}
