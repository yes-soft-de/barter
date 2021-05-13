import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_chat/ui/active_chats/active_chats.dart';
import 'package:barter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_services/services_routes.dart';
import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_settings/ui/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeScreen extends StatefulWidget {
  final SettingsScreen _settingsScreen;
  final ServicesScreen _servicesScreen;
  final UserProfileScreen _profileScreen;
  final AuthService _authService;
  final ActiveChatsScreen _activeChats;
  final NotificationScreen _notificationScreen;

  HomeScreen(this._settingsScreen, this._servicesScreen, this._profileScreen,
      this._authService, this._activeChats, this._notificationScreen);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _getActiveScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._authService.isLoggedIn.then((value) {
            if (!value) {
              Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
            } else {
              Navigator.of(context).pushNamed(ServicesRoutes.ROUTE_ADD_SERVICE);
            }
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _activeIndex,
        onTap: (pos) {
          _activeIndex = pos;
          if (mounted) setState(() {});
          return pos;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notifications',
          ),
        ],
      ),
    );
  }

  Widget _getActiveScreen() {
    switch (_activeIndex) {
      case 0:
        return widget._servicesScreen;
      case 1:
        return widget._profileScreen;
      case 2:
        return widget._activeChats;
      case 3:
        return widget._settingsScreen;
      case 4:
        return widget._notificationScreen;
      default:
        return widget._servicesScreen;
    }
  }
}
