import 'package:flutter/material.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';

class NotificationComplete extends StatefulWidget {
  final NotificationModel notification;
  final String myId;

  NotificationComplete({
    this.notification,
    this.myId,
  });

  @override
  _NotificationCompleteState createState() => _NotificationCompleteState();
}

class _NotificationCompleteState extends State<NotificationComplete> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
      child: Card(
        elevation: 4,
        color: Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black,
        child: _getConfirmationOverlay()
      ),
    );
  }

  Widget _getConfirmationOverlay() {
    return Container(
      height: 165,
      color: Colors.black38,
      child: Center(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
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
              title:  Text(widget.notification.swap.userTowName,style: TextStyle(color: Colors.white,),),
            ),
            Text(
              'Swap Completed',
              //S.of(context).swapCompleted,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCardFooter() {
    return Container(
      height: 48,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${widget.notification.userImage}'),
                ),
              ),
            ),
          ),
          // Text(widget.notification.gameTwo.userID == widget.myId
          //     ? widget.notification.gameOne.userName
          //     : widget.notification.gameTwo.userName)
        ],
      ),
    );
  }
}
