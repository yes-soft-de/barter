import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_init/init_routes.dart';
import 'package:barter/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/profile_response.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_localization/service/localization_service/localization_service.dart';
import 'package:barter/module_theme/service/theme_service/theme_service.dart';
import 'package:barter/module_auth/enums/user_type.dart';

@provide
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;
  final ProfileService _profileService;
  final FireNotificationService _notificationService;

  SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
    this._profileService,
    this._notificationService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         'Settings',// S.of(context).settings,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      //S.of(context).darkMode
                      ),
                    Switch(
                        value: Theme.of(context).brightness == Brightness.dark,
                        onChanged: (mode) {
                          widget._themeDataService
                              .switchDarkMode(mode)
                              .then((value) {});
                        })
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProfileRoutes.EDIT_PROFILE_SCREEN);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User Profile'),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // FutureBuilder(
          //   future: widget._authService.userRole,
          //   builder: (BuildContext context, AsyncSnapshot<UserRole> snapshot) {
          //     if (snapshot.data == UserRole.ROLE_COMPANY) {
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(Radius.circular(8)),
          //             color: Colors.black12,
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Flex(
          //               direction: Axis.horizontal,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Renew Subscription',
          //                   //S.of(context).renewSubscription
          //                   ),
          //                 IconButton(
          //                     icon: Icon(Icons.autorenew_sharp),
          //                     onPressed: () {
          //                       Navigator.of(context).pushNamed(
          //                           InitAccountRoutes.INIT_ACCOUNT_SCREEN);
          //                     }),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
          // FutureBuilder(
          //   future: _getCaptainStateSwitch(),
          //   builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          //     if (snapshot.hasData) {
          //       return snapshot.data;
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Language',
                      //S.of(context).language
                      ),
                    FutureBuilder(
                      future: widget._localizationService.getLanguage(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return DropdownButton(
                            value: snapshot.data,
                            items: [
                              DropdownMenuItem(
                                child: Text('العربية'),
                                value: 'ar',
                              ),
                              DropdownMenuItem(
                                child: Text('English'),
                                value: 'en',
                              ),
                            ],
                            onChanged: (String newLang) {
                              widget._localizationService.setLanguage(newLang);
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: widget._authService.isLoggedIn,
                  initialData: false,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign out',
                            //S.of(context).signOut
                            ),
                          IconButton(
                              icon: Icon(Icons.logout),
                              onPressed: () {
                                widget._authService.logout().then((value) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AuthorizationRoutes.LOGIN_SCREEN,
                                      (route) => false);
                                });
                              })
                        ],
                      );
                    } else {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Login',
                           // S.of(context).login
                            ),
                          IconButton(
                              icon: Icon(Icons.login),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AuthorizationRoutes.LOGIN_SCREEN);
                              })
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _getCaptainStateSwitch() async {
    var userRole = await widget._authService.userRole;
    print('${userRole}');
    if (userRole == UserRole.ROLE_COMPANY) {
      return Container();
    } else {
      // The User is a captain
      var profile = await widget._profileService.getMyProfile();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.black12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Status',
                 // S.of(context).myStatus
                  ),
                Switch(
                  onChanged: (bool value) {
                    widget._notificationService.setCaptainActive(value);
                    widget._profileService.updateProfile(
                      ProfileRequest(
                        userName: profile.firstName,
                        lastName: profile.lastName,
                        image: profile.image,
                        phone: profile.phone,
                        location: profile.location,
                      ),
                    );
                  },
                  value: profile.location != null,
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
