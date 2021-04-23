import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'edit_service_state.dart';

class EditServiceStateLoading extends EditServiceState {
  EditServiceStateLoading(EditServiceScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
