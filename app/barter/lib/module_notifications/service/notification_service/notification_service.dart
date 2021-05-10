import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:uuid/uuid.dart';

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
      notifications.add(NotificationModel(
        chatRoomId: value.chatRoomId,
        swapId: value.id.toString(),
        userImage:
        myId == value.userOneId ? value.userTowImage : value.userOneImage,
        swap: SwapModel(
            chatRoomId: value.chatRoomId,
            userTowImage: value.userTowImage,
            id: value.id,
            userTowName: value.userTowName,
            userTowId: value.userTowId
        ),
        status: value.status,
        date: value.date,
        restrictedItemsUserOne: value.swapItemsOne,
        restrictedItemsUserTwo: value.swapItemsTow,
      ));
    });

   // notifications.sort((e1, e2) => e2.date.compareTo(e1.date));
    return notifications.toList();
  }

 Future<SwapModel> updateSwap(NotificationModel swapItemModel) async{
   SwapModel swapModel =  SwapModel(
     id: swapItemModel.swapId,
     chatRoomId: swapItemModel.chatRoomId,
     status: swapItemModel.status,
     swapItemsOne: swapItemModel.restrictedItemsUserOne,
     swapItemsTow: swapItemModel.restrictedItemsUserTwo
   );
    var response = await _swapService.updateSwap(swapModel);
    if(response==null){
      return null;
    }
    return response;
  }

}
