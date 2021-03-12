import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state_loaded.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state_loading.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class ServiceScreenStateManager {
  final stateSubject = PublishSubject<ServiceListState>();

  final ServicesService _servicesService;

  ServiceScreenStateManager(this._servicesService);

  void getServices(ServicesScreen screen) {
    stateSubject.add(ServiceListStateLoading(screen));
    _servicesService.getMembers().then((value) {
      stateSubject.add(
        ServiceListStateLoaded(screen, value),
      );
    });
  }
}
