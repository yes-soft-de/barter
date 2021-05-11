import 'package:barter/module_notifications/ui/state/service_list_state/notification_state.dart';
import 'package:barter/module_notifications/ui/state/service_list_state/notification_state_loaded.dart';
import 'package:barter/module_notifications/ui/state/service_list_state/notification_state_loading.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:barter/consts/keys.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:barter/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:barter/module_notifications/service/notification_service/notification_service.dart';

@provide
class NotificationsStateManager {
  final PublishSubject<NotificationState> _stateSubject = PublishSubject();
  Stream<NotificationState> get stateStream => _stateSubject.stream;

  final NotificationService _service;
  final SwapService _swapService;

  NotificationsStateManager(this._service, this._swapService) {
    FireNotificationService.onNotificationStream.listen((event) {
      getNotifications();
    });
  }

  void getNotifications() {
    _service.getNotifications().then((value) {
      if (value != null) {
        _stateSubject.add(NotificationStateLoadSuccess(value));
      } else {
        _stateSubject.add(NotificationStateLoading());
      }
    });
  }

  void updateSwap(NotificationModel swapItemModel) {

     swapItemModel.status = ApiKeys.KEY_SWAP_STATUS_STARTED;
     _service.updateSwap(swapItemModel).then((value) {
       if(value!=null)
       getNotifications();
     });
  }

}
