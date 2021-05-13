import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_chat/args/chat_arguments.dart';
import 'package:barter/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:barter/module_chat/chat_routes.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ActiveChatsScreen extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;
  final AuthService _authService;
  ActiveChatsScreen(this._chatPageBloc, this._authService);
  @override
  State<StatefulWidget> createState() => _ActiveChatsScreenState();
}

class _ActiveChatsScreenState extends State<ActiveChatsScreen> {
  List<NotificationModel> chatList;
  String myId;
  bool init = false;
  @override
  void initState() {
    super.initState();
    widget._authService.isLoggedIn.then((authorized) {
      if (authorized == false || authorized == null) {
        Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
        return;
      } else {
        widget._authService.userID.then((value) {
          myId = value;
          init = true;
          setState(() {});
        });
      }
    });
    widget._chatPageBloc.acticeChatsStream.listen((event) {
      chatList = event;
      init = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (init) {
      widget._chatPageBloc.getActiveChats();
    }
    return Scaffold(
        body: SafeArea(
      child: chatList != null
          ? Column(children: _buildChatCard(chatList))
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }

  List<Widget> _buildChatCard(List<NotificationModel> chats) {
    if (chats.isEmpty) {
      return [
        Container(
          child: Text(' no chats'),
        )
      ];
    }
    List<Widget> _cards = [];
    chats.forEach((element) {
      _cards.add(Card(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                arguments: ChatArguments(
                    chatRoomId: element.chatRoomId,
                    notification: element,
                    myId: myId));
          },
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text(
              myId == element.swap.userOneId
                  ? element.swap.userTowName.toString()
                  : element.swap.userOneName.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(element.status),
          ),
        ),
      ));
    });
    return _cards;
  }
}
