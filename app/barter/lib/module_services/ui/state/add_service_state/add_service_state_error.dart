import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddServiceStateError extends AddServiceState {
  final String error;

  AddServiceStateError(AddServiceScreen screen, this.error) : super(screen);

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
