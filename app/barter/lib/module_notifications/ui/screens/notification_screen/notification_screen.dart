import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_notifications/ui/state/notifications_list_state/notification_state.dart';
import 'package:barter/module_notifications/ui/state/notifications_list_state/notification_state_loaded.dart';
import 'package:barter/module_notifications/ui/state/notifications_list_state/notification_state_loading.dart';
import 'dart:core';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:barter/consts/keys.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_chat/args/chat_arguments.dart';
import 'package:barter/module_chat/chat_routes.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:barter/module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'package:barter/module_notifications/ui/widget/notification_confirmation_pending/notification_confirmation_pending.dart';
import 'package:barter/module_notifications/ui/widget/notification_confirmed/notification_confirmed.dart';
import 'package:barter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:barter/module_notifications/ui/widget/notification_swap_start/notification_swap_start.dart';
import 'package:fluttertoast/fluttertoast.dart';
@provide
class NotificationScreen extends StatefulWidget {
  final NotificationsStateManager _manager;
  final AuthService _authService;
  final ProfileService _myProfileService;

  NotificationScreen(
    this._manager,
    this._myProfileService,
    this._authService,
  );

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationState currentState;
  int viewLimit = 10;
  bool initiated = false;

  List<NotificationModel> notifications;

  @override
  void initState() {
    super.initState();
    currentState = NotificationStateLoading();

    widget._authService.isLoggedIn.then((authorized) {
      if (authorized == false || authorized == null) {
        Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initiated) {
      initiated = true;
      widget._manager.stateStream.listen((event) {
        currentState = event;
        if (mounted) setState(() {});
      });
      widget._manager.getNotifications();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (currentState is NotificationStateLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (currentState is NotificationStateLoadSuccess) {
        NotificationStateLoadSuccess state = currentState;
        notifications = state.notifications;
        return FutureBuilder(
            future: widget._authService.userID,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return getNotificationsList(snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            });
      } else if (currentState is NotificationStateLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Flex(
          direction: Axis.vertical,
          children: [
            Text(
              'Error Loading Data',
              //   S.of(context).errorLoadingData
            ),
            OutlinedButton(
              child: Text('Retry'), // S.of(context).retry),
              onPressed: () {
                widget._manager.getNotifications();
              },
            )
          ],
        );
      }
    }
  }

  Widget getNotificationsList(String myId) {
    List<Widget> notCards = [];

    if (notifications != null) {
      if (notifications.isNotEmpty) {
        notifications.forEach((n) {
          notCards.add(
            _getAppropriateNotificationCard(n, myId),
          );
        });
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          (notCards.isEmpty)?
              Container(child:Text('No Notifications')):
          Flex(
            direction: Axis.vertical,
            children: notCards,
          ),
        ],
      ),
    );
  }

  Widget _getAppropriateNotificationCard(
    NotificationModel n,
    String myId,
  ) {
    if (n == null) {

      return Container();
    }
    //  return Card(child: Text('Notification Status: ${n.status}'));
    if (n.status == null || n.status == ApiKeys.KEY_SWAP_STATUS_INITIATED) {
      return myId != n.swap.userOneId
          ? NotificationSwapStart(
              notification: n,
              myId: myId,
              onChangeSwap: (accept) {
                if (accept) {
                  _onChangeRequest(n);
                } else {
                  widget._manager.setSwapReject(n);
                }
              })
          : SizedBox.shrink();
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_FIRST_USER_ACCEPTED ||
        n.status == ApiKeys.KEY_SWAP_STATUS_SECOND_USER_ACCEPTED) {
      return NotificationSwapConfirmationPending(
        canComplete: (myId == n.swap.userOneId) ? true : false,
        notification: n,
        myId: myId,
        onCompleted: () {
          _onChangeRequest(n);
        },
        onRrjected: () {
          widget._manager.setSwapReject(n);
        },
      );
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_STARTED) {
      return NotificationOnGoing(
        notification: n,
        myId: myId,
        onChatRequested: () {
          var args = ChatArguments(
              chatRoomId: n.chatRoomId, notification: n, myId: myId);

          Navigator.of(context).pushNamed(
            ChatRoutes.chatRoute,
            arguments: args,
          );
        },
      );
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_COMPLETE) {
      return NotificationComplete(
        notification: n,
        myId: myId,
      );
    } else {
      return Card(child: Text('Notification Status: ${n.status}'));
    }
  }

  void _onChangeRequest(NotificationModel n) {
    Fluttertoast.showToast(
        msg: "sending request",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 20.0
    );

    if (n.status == ApiKeys.KEY_SWAP_STATUS_INITIATED) {
      widget._manager.setSwapStarted(n);
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_FIRST_USER_ACCEPTED ||
        n.status == ApiKeys.KEY_SWAP_STATUS_SECOND_USER_ACCEPTED) {
      widget._manager.setSwapComplete(n);
    }
  }
}
