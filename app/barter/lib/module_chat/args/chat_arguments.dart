import 'package:flutter/cupertino.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';

class ChatArguments {
  final String chatRoomId;
  final NotificationModel notification;

  ChatArguments({
    @required this.chatRoomId,
    @required this.notification,
  });
}
