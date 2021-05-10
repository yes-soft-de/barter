import 'package:barter/module_swap/model/swap_model.dart';
import 'package:flutter/material.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';

class NotificationSwapStart extends StatefulWidget {
  final NotificationModel notification;
  final String myId;
  final Function(bool) onChangeSwap;
  NotificationSwapStart(
      {@required this.notification,
      @required this.myId,
        @required this.onChangeSwap
      });

  @override
  State<StatefulWidget> createState() => _NotificationSwapStartState();
}

class _NotificationSwapStartState extends State<NotificationSwapStart> {
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
          height: 140,
          child: Flex(
            direction: Axis.vertical,
            children: [
              _getCardHeader(),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  RaisedButton(onPressed: (){
                    widget.onChangeSwap(false);
                  }
                  ,color: Colors.blueAccent,
                    child: Text('DECLINE',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(onPressed: (){
                    widget.onChangeSwap(true);
                  }
                    ,color: Colors.blueAccent,
                    child: Text('ACCEPT',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCardHeader() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListTile(
        leading:Image.network(widget.notification.swap.userTowImage,
          fit: BoxFit.cover,
          errorBuilder: (e,r,t){
            return Image.asset('assets/images/logo.png');
          },
        ) ,
        title:  Text(widget.notification.swap.userTowName),
        subtitle: Text('this Person / Company ask you for swaping'),
      ),
    );

  }
}
