import 'package:barter/module_swap/model/swap_items_model.dart';

class SwapModel {
  final String id;
  final String userOneId;
  final String userTowId;
  final String userOneName;
  final String userTowName;
  final String userOneImage;
  final String userTowImage;
  final String chatRoomId;
  final List<SwapItemsModel> swapItemsOne;
  final List<SwapItemsModel> swapItemsTow;
  final bool accepted;
  final DateTime date;
  final String status ;

  SwapModel({
    this.id,
    this.userOneId,
    this.userTowId,
    this.userOneName,
    this.userTowName,
    this.userOneImage,
    this.userTowImage,
    this.chatRoomId,
    this.swapItemsOne,
    this.swapItemsTow,
    this.accepted,
    this.date,
    this.status
  });
}
