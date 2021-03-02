import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_settings/ui/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeScreen extends StatefulWidget {
  final SettingsScreen _settingsScreen;
  final ServicesScreen _servicesScreen;
  final EditProfileScreen _profileScreen;

  HomeScreen(
    this._settingsScreen,
    this._servicesScreen,
    this._profileScreen,
  );

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
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.miscellaneous_services),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
        return widget._settingsScreen;
      default:
        return widget._servicesScreen;
    }
  }
}
