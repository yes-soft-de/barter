import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationSwapConfirmationPending extends StatefulWidget {
  final NotificationModel notification;
  final String myId;
  final bool canComplete;
  final Function() onCompleted;
  final Function() onRrjected;

  NotificationSwapConfirmationPending({
    this.notification,
    this.myId,
    this.onCompleted,
    this.onRrjected,
    this.canComplete,
  });

  @override
  State<StatefulWidget> createState() =>
      _NotificationSwapConfirmationPendingState();
}

class _NotificationSwapConfirmationPendingState
    extends State<NotificationSwapConfirmationPending> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
      child: Card(
        elevation: 4,
        color: Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black,
        child: Container(
          height: 168,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: 60,
                    height: 100,
                    child: Image.network(
                      widget.myId == widget.notification.swap.userOneId
                          ? widget.notification.swap.userTowImage
                          : widget.notification.swap.userOneImage,
                      fit: BoxFit.cover,
                      errorBuilder: (e, r, t) {
                        return Image.asset('assets/images/logo.png');
                      },
                    ),
                  ),
                ),
                title: Text(
                  widget.myId == widget.notification.swap.userOneId
                      ? widget.notification.swap.userTowName
                      : widget.notification.swap.userOneName,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              _getConfirmationOverlay()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getConfirmationOverlay() {
  return  Container(
      color: Colors.black38,
      child: Center(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pending Confirmation',
              //    S.of(context).pendingConfirmation,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    }
  }

