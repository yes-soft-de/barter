import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:barter/fluttertoast.dart';
import 'package:barter/generated/l10n.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';

class NotificationOnGoing extends StatefulWidget {
  final NotificationModel notification;
  final String myId;
  final Function() onChangeRequest;
  final Function(String) onSwapComplete;
  final Function() onChatRequested;
  final bool shrink;

  NotificationOnGoing({
    @required this.notification,
    @required this.myId,
    this.onChangeRequest,
    this.onChatRequested,
    this.onSwapComplete,
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
                trailing:                   IconButton(
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

  // Widget _getGamesRow() {
  //   return Stack(
  //     children: [
  //       Flex(
  //         direction: Axis.horizontal,
  //         children: [
  //           Flexible(
  //             flex: 1,
  //             fit: FlexFit.tight,
  //             child: _gameSelector(widget.notification.swapOne),
  //           ),
  //           Flexible(
  //             flex: 1,
  //             fit: FlexFit.tight,
  //             child: _gameSelector(widget.notification.swapTwo),
  //           )
  //         ],
  //       ),
  //       // Positioned.fill(
  //       //   child: widget.notification.gameOne.id != -1 &&
  //       //           widget.notification.gameTwo.id != -1
  //       //       ? Center(
  //       //           child: Container(
  //       //             decoration: BoxDecoration(
  //       //               color: SwapThemeDataService.getPrimary(),
  //       //               shape: BoxShape.circle,
  //       //             ),
  //       //             child: IconButton(
  //       //               icon: Icon(Icons.check),
  //       //               onPressed: () {
  //       //                 widget.onSwapComplete(widget.notification.swapId);
  //       //               },
  //       //             ),
  //       //           ),
  //       //         )
  //       //       : Container(),
  //       // )
  //     ],
  //   );
  // }

  // Widget _gameSelector(Games game) {
  //   return Stack(
  //     children: [
  //       Positioned.fill(
  //         child: FadeInImage.assetNetwork(
  //           placeholder: 'assets/images/logo.jpg',
  //           image: game.mainImage ?? '',
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       Positioned.fill(
  //         child: Container(
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(12),
  //             ),
  //           ),
  //           child: GestureDetector(
  //             onTap: () {
  //               widget.onChangeRequest(game);
  //             },
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: SwapThemeDataService.getAccent(),
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Icon(
  //                   Icons.refresh,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
