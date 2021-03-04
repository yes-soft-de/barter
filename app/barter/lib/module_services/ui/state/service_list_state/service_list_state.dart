import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class ServiceListState {
  final ServicesScreen screen;

  ServiceListState(this.screen);

  Widget getUI(BuildContext context);
}