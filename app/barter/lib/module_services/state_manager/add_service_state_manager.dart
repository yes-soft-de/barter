import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_services/ui/screen/add_service_screen.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state_categories_loaded.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state_error.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state_loading.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state_success.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AddServiceStateManager {
  final stateStream = PublishSubject<AddServiceState>();
  final ServicesService _service;
  AddServiceStateManager(this._service);

  void addService(AddServiceScreen screen, ServiceModel serviceModel) {
    _service.addService(serviceModel).then((value) {
      if (value == null) {
        stateStream.add(AddServiceStateSuccess(screen));
      } else {
        stateStream.add(AddServiceStateError(screen, 'Error Saving the service'));
      }
    });
  }

  void getCategories(AddServiceScreen screen) {
    _service.getCategories().then((value) {
      if (value != null) {
        stateStream.add(AddServiceStateCategoriesAdded(screen, value));
      } else {
        stateStream.add(AddServiceStateError(screen, 'Error loading categories!'));
      }
    });
  }
}