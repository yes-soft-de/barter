import 'package:barter/module_chat/chat_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ActiveChatsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActiveChatsScreenState();
}

class _ActiveChatsScreenState extends State<ActiveChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
      children: [
          Card(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute, arguments: 'public');
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Chat Room 01'),
                subtitle: Text('Some Text'),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute, arguments: 'public');
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Chat Room 02'),
                subtitle: Text('Some Text'),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute, arguments: 'public');
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Chat Room 03'),
                subtitle: Text('Some Text'),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute, arguments: 'public');
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Chat Room 04'),
                subtitle: Text('Some Text'),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute, arguments: 'public');
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Chat Room 05'),
                subtitle: Text('Some Text'),
              ),
            ),
          ),
      ],
    ),
        ));
  }
}
