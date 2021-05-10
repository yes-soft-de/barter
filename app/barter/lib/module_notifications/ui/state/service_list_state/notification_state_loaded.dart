import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:barter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:barter/module_services/model/members_model.dart';
import 'package:barter/module_services/ui/widget/service_card.dart';
import 'package:barter/module_services/ui/widget/yes_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'notification_state.dart';

class NotificationStateLoadSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationStateLoadSuccess( this.notifications) : super();

  @override
  Widget getUI(BuildContext context) {
    return Container();
  }

  
}
