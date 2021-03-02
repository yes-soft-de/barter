import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ServiceListStateLoading extends ServiceListState {
  ServiceListStateLoading(ServicesScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}