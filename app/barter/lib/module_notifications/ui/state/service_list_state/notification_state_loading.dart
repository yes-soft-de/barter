import 'package:barter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'notification_state.dart';

class NotificationStateLoading extends NotificationState {
  NotificationStateLoading() : super();

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}