import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class EditServiceState {
  final EditServiceScreen screen;
  EditServiceState(this.screen);

  Widget getUI(BuildContext context);
}
