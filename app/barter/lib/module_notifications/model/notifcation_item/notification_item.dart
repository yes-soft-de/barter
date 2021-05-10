import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationModel {
  SwapModel swap;
 // SwapModel swapOne;
//  SwapModel swapTwo;
  String chatRoomId;
  String swapId;
  String userImage;
  String status;
  DateTime date;
  List<SwapItemsModel> restrictedItemsUserOne;
  List<SwapItemsModel> restrictedItemsUserTwo;

  NotificationModel({
    @required this.swap,
   // @required this.swapOne,
    //@required this.swapTwo,
    @required this.chatRoomId,
    @required this.status,
    @required this.date,
    @required this.userImage,
    @required this.swapId,
    @required this.restrictedItemsUserOne,
    @required this.restrictedItemsUserTwo,
  });
}
