import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class AddServiceState {
  final AddServiceScreen screen;

  AddServiceState(this.screen);

  Widget getUI(BuildContext context);
}