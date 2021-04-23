import 'package:barter/abstracts/module/yes_module.dart';
import 'package:barter/module_services/services_routes.dart';
import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ServicesModule extends YesModule {
  final AddServiceScreen _addServiceScreen;
  final EditServiceScreen _editServiceScreen;
  ServicesModule(this._addServiceScreen, this._editServiceScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ServicesRoutes.ROUTE_ADD_SERVICE: (context) => _addServiceScreen,
      ServicesRoutes.ROUTE_EDIT_SERVICE: (context) => _editServiceScreen
    };
  }
}
