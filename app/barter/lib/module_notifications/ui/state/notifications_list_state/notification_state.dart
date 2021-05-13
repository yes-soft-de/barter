import 'package:flutter/cupertino.dart';

abstract class NotificationState {
  NotificationState();

  Widget getUI(BuildContext context);
}
