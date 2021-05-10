import 'package:barter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class NotificationState {

  NotificationState();

  Widget getUI(BuildContext context);
}