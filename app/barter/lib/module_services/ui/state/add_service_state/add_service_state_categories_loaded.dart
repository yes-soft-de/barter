import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_services/model/category_model.dart';
import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:barter/module_services/ui/widget/create_service_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddServiceStateCategoriesAdded extends AddServiceState {
  final List<CategoryModel> categories;
  AddServiceStateCategoriesAdded(AddServiceScreen screen, this.categories) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CreateServiceForm(
            categories: categories,
            onServiceAdd: (service) {
              screen.addService(service);
            },
          ),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Done'), //S.of(context).save),
              onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, HomeRoutes.HOME_ROUTE, (route) => false);

              })
        ],
      ),
    );
  }
}