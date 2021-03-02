import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:barter/module_services/ui/widget/create_service_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddServiceStateCategoriesAdded extends AddServiceState {
  final List<String> categories;
  AddServiceStateCategoriesAdded(AddServiceScreen screen, this.categories) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return CreateServiceForm(
      categories: categories,
      onServiceAdd: (service) {
        // TODO: Add When Adding Service Behaviour
      },
    );
  }
}