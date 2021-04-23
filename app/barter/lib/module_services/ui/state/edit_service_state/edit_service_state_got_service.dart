import 'package:barter/module_services/model/category_model.dart';
import 'package:barter/module_services/request/edit_service_request.dart';
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:barter/module_services/ui/widget/edit_service_form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'edit_service_state.dart';

class EditServiceStateGotServce extends EditServiceState {
  EditServiceRequest request;
  final List<CategoryModel> categories;
  EditServiceStateGotServce(
      EditServiceScreen screen, this.request, this.categories)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return EditServiceForm(
      categories: categories,
      onServiceEdit: (request) {
        screen.editService(request);
      },
      request: request,
    );
  }
}
