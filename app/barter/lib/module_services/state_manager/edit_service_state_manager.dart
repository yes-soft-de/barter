import 'package:barter/module_auth/exceptions/auth_exception.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/request/edit_service_request.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:barter/module_services/ui/state/edit_service_state/edit_service_state.dart';
import 'package:barter/module_services/ui/state/edit_service_state/edit_service_state_error.dart';
import 'package:barter/module_services/ui/state/edit_service_state/edit_service_state_got_service.dart';
import 'package:barter/module_services/ui/state/edit_service_state/edit_service_state_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EditServiceStateManager {
  final stateStream = PublishSubject<EditServiceState>();
  final ServicesService _service;
  EditServiceStateManager(this._service);

  void editService(EditServiceScreen screen, ServiceModel serviceModel) {
    _service.editService(serviceModel).then((value) {
      if (value != null) {
        stateStream.add(EditServiceStateSuccess(screen));
      } else {
        stateStream
            .add(EditServiceStateError(screen, 'Error Saving the service'));
      }
    });
  }

  void getServiceById(EditServiceScreen screenState, id) {
    // stateStream.add(EditServiceStateLoading(
    //   screenState,
    // ));
    _service.getCategories().then((value1) {
      if (value1 != null) {
        _service.getServiceById(id).then((value2) {
          if (value2 == null) {
            stateStream.add(EditServiceStateError(
                screenState, 'Error loading service detial!'));
          } else {
            stateStream.add(EditServiceStateGotServce(
                screenState,
                EditServiceRequest(
                  id: value2.id,
                  serviceTitle: value2.name,
                  description: value2.description,
                  enabled: true,
                  categoryID: value2.categoryId,
                ),
                value1));
          }
        }).catchError((e) {
          debugPrint(e.toString());
          if (e is UnauthorizedException) {
            //unauthorize state;
            // screenState.moveToLogin();
          }
        });
      } else {
        stateStream.add(
            EditServiceStateError(screenState, 'Error loading categories!'));
      }
    });
  }
}
