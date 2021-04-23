
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'edit_service_state.dart';

class EditServiceStateError extends EditServiceState {
  final String error;
  EditServiceStateError(EditServiceScreen screen, this.error) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Center(child: Text('${error}')),
      ],
    );
  }
}
