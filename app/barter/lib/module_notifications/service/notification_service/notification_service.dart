import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:uuid/uuid.dart';
import 'package:barter/module_auth/exceptions/auth_exception.dart';

@provide
class NotificationService {
  final SwapService _swapService;
  final AuthService _authService;

  NotificationService(
    this._swapService,
    this._authService,
  );

  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> notifications = [];
    List<SwapModel> swaps = await _swapService.getSwapRequests();

    var myId = await _authService.userID;
    if (swaps == null) {
      return null;
    }
    swaps.forEach((value) {
      print(value.status);
      notifications.add(NotificationModel(
        chatRoomId: value.chatRoomId,
        swapId: value.id.toString(),
        userImage:
            myId == value.userOneId ? value.userTowImage : value.userOneImage,
        swap: value,
        status: value.status,
        date: value.date,
        restrictedItemsUserOne: value.swapItemsOne,
        restrictedItemsUserTwo: value.swapItemsTow,
      ));
    });

    return notifications.toList();
  }

  Future<SwapModel> updateSwap(NotificationModel swapItemModel) async {
    if(swapItemModel.swap.chatRoomId == null)
      swapItemModel.chatRoomId =  Uuid().v1();

    SwapModel swapModel = SwapModel(
        id: swapItemModel.swapId,
        chatRoomId: swapItemModel.chatRoomId ,
        status: swapItemModel.status,
        swapItemsOne: swapItemModel.restrictedItemsUserOne,
        swapItemsTow: swapItemModel.restrictedItemsUserTwo);
    var response = await _swapService.updateSwap(swapModel);
    if (response == null) {
      return null;
    }
    return response;
  }
}
