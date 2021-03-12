import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddServiceStateSuccess extends AddServiceState {
  AddServiceStateSuccess(AddServiceScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Center(
            child: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeRoutes.HOME_ROUTE, (r) => false);
          },
        )),
      ],
    );
  }
}
