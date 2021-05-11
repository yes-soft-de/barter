import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:barter/fluttertoast.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';

class NotificationOnGoing extends StatefulWidget {
  final NotificationModel notification;
  final String myId;
  final Function() onChatRequested;
  final bool shrink;

  NotificationOnGoing({
    @required this.notification,
    @required this.myId,
    this.onChatRequested,
    this.shrink,
  });

  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationOnGoing> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
      child: Card(
        elevation: 4,
        color: Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              alignment: Alignment.center,
              height: 120,
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading:ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                  width: 60,
                    height: 100,
                    child: Image.network(widget.notification.swap.userTowImage,
                      fit: BoxFit.cover,
                      errorBuilder: (e,r,t){
                        return Image.asset('assets/images/logo.png');
                      },
                    ),
                  ),
                ) ,
                title:  Text(widget.notification.swap.userTowName),
                trailing: IconButton(
                    icon: widget.notification.chatRoomId != null
                        ? Icon(
                      Icons.chat,
                      color:Colors.blue,// SwapThemeDataService.getPrimary(),
                    )
                        : Icon(
                      Icons.check,
                      color: Colors.blue,//SwapThemeDataService.getPrimary(),
                    ),
                    onPressed: () {
                      if (widget.notification.chatRoomId != null) {
                        widget.onChatRequested();
                      } else {
//                         Fluttertoast.showToast(
//                           msg: S.of(context).pendingApproval,
//                         );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }


}
