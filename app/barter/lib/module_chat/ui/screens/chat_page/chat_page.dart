import 'package:barter/consts/keys.dart';
import 'package:barter/module_notifications/service/notification_service/notification_service.dart';
import 'package:barter/module_notifications/ui/widget/notification_change_swap_items/change_item_form.dart';
import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_chat/args/chat_arguments.dart';
import 'package:barter/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:barter/module_chat/model/chat/chat_model.dart';
import 'package:barter/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:barter/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:barter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:barter/module_upload/service/image_upload/image_upload_service.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;
  final AuthService _authService;
  final SwapService _swapService;
  final NotificationService _notificationService;
  final ImageUploadService _uploadService;

  ChatPage(
    this._chatPageBloc,
    this._authService,
    this._swapService,
    this._notificationService,
    this._uploadService,
  );

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList = [];
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  List<ChatBubbleWidget> chatsMessagesWidgets = [];

  String chatRoomId;
  String myId;
  NotificationModel activeNotification;
  bool initiated = false;

  List<SwapItemsModel> myServices = [];
  List<SwapItemsModel> targetServices = [];
  bool getServices = true;
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is ChatArguments) {
      ChatArguments args = ModalRoute.of(context).settings.arguments;
      activeNotification = args.notification;
      chatRoomId = args.chatRoomId;
      myId = args.myId;
      widget._chatPageBloc.notificationStream.listen((event) {
        activeNotification.swap = event.swap;
      });

      // for get all services (for update)

      if (getServices)
        widget._swapService.getMyItems().then((value1) {
          widget._swapService
              .getTargetItems(
                  args.notification.restrictedItemsUserTwo[0].id.toString())
              .then((value2) {
            if (value2 == null || value1 == null) {
              myServices = targetServices = null;
            } else {
              myServices = value1;
              targetServices = value2;
              getServices = !getServices;
              setState(() {});
            }
          });
        });
    } else {
      chatRoomId = ModalRoute.of(context).settings.arguments;
    }

    if (currentState == ChatPageBloc.STATUS_CODE_INIT) {
      widget._chatPageBloc.getMessages(chatRoomId);
    }

    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length == _chatMessagesList.length) {
        } else {
          buildMessagesList(_chatMessagesList).then((value) {
            if (this.mounted) setState(() {});
          });
        }
      }
    });

    return Scaffold(
      body: Column(
        // direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppBar(
            title: Text(
              'Chat Room',
              //S.of(context).chatRoom
            ),
          ),
          Expanded(
            child: ListView(
              reverse: true,
              children: [
                chatsMessagesWidgets != null
                    ? Column(
                        children: chatsMessagesWidgets,
                      )
                    : Center(
                        child: Text('Loading'
                            //S.of(context).loading
                            ),
                      ),
                (activeNotification.swap == null)
                    ? Container()
                    : MediaQuery.of(context).viewInsets.bottom == 0
                        ? FutureBuilder(
                            future: widget._authService.userID,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              return (myServices.isEmpty)
                                  ? Text('Load Data')
                                  : (myServices == null ||
                                          targetServices == null)
                                      ? Text('Error in load services')
                                      : ChangeItemForm(
                                          onSwapChange: (notification) {
                                            if (activeNotification
                                                    .swap.userOneId ==
                                                myId) {
                                              if (notification.status ==
                                                  ApiKeys
                                                      .KEY_SWAP_STATUS_SECOND_USER_ACCEPTED) {
                                                notification.status = ApiKeys
                                                    .KEY_SWAP_STATUS_COMPLETE;
                                              } else if (notification.status ==
                                                  ApiKeys
                                                      .KEY_SWAP_STATUS_STARTED) {
                                                notification.status = ApiKeys
                                                    .KEY_SWAP_STATUS_FIRST_USER_ACCEPTED;
                                              }
                                            } else if (activeNotification
                                                    .swap.userTowId ==
                                                myId) {
                                              if (notification.status ==
                                                  ApiKeys
                                                      .KEY_SWAP_STATUS_FIRST_USER_ACCEPTED) {
                                                notification.status = ApiKeys
                                                    .KEY_SWAP_STATUS_COMPLETE;
                                              } else if (notification.status ==
                                                  ApiKeys
                                                      .KEY_SWAP_STATUS_STARTED) {
                                                notification.status = ApiKeys
                                                    .KEY_SWAP_STATUS_SECOND_USER_ACCEPTED;
                                              }
                                            }
                                            widget._notificationService
                                                .updateSwap(notification);
                                            widget._chatPageBloc
                                                .setNotificationComplete(
                                                    notification);
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                    content:
                                                        Text('Saving Data')));
                                            setState(() {});
                                          },
                                          notificationModel: activeNotification,
                                          myItems: myServices,
                                          targetItems: targetServices,
                                        );
                            },
                          )
                        : Container(),
              ],
            ),
          ),
          ChatWriterWidget(
            onMessageSend: (msg) {
              widget._chatPageBloc.sendMessage(chatRoomId, msg);
            },
            uploadService: widget._uploadService,
          ),
        ],
      ),
    );
  }

  void checkUpdates() {
    widget._chatPageBloc.checkSwapUpdates(chatRoomId);
    Future.delayed(Duration(seconds: 15), () {
      checkUpdates();
    });
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<ChatBubbleWidget> newMessagesList = [];
    FirebaseAuth auth = await FirebaseAuth.instance;
    User user = auth.currentUser;
    chatList.forEach((element) {
      newMessagesList.add(ChatBubbleWidget(
        message: element.msg,
        me: element.sender == user.uid ? true : false,
        sentDate: element.sentDate,
      ));
    });
    chatsMessagesWidgets = newMessagesList;
    return;
  }
}
