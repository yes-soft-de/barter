import 'dart:async';
import 'package:barter/module_auth/authorization_routes.dart';
import 'package:barter/module_auth/repository/auth/auth_repository.dart';
import 'package:barter/module_chat/chat_module.dart';
import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_home/module_home.dart';
import 'package:barter/module_localization/service/localization_service/localization_service.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:barter/module_notifications/service/notification_service/notification_service.dart';
import 'package:barter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:barter/module_profile/module_profile.dart';
import 'package:barter/module_services/state_manager/edit_service_state_manager.dart';
import 'package:barter/module_services/ui/screen/edit_service_screen.dart';
import 'package:barter/module_swap/state_manager/list_swap_state_manager.dart';
import 'package:barter/module_swap/swap_module.dart';
import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_theme/service/theme_service/theme_service.dart';
import 'package:barter/utils/auth_guard/auth_gard.dart';
import 'package:barter/utils/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'di/components/app.component.dart';
import 'module_auth/authoriazation_module.dart';
import 'module_auth/manager/auth_manager/auth_manager.dart';
import 'module_auth/presistance/auth_prefs_helper.dart';
import 'module_auth/service/auth_service/auth_service.dart';
import 'module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'module_auth/ui/screen/login_screen/login_screen.dart';
import 'module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'module_chat/manager/chat/chat_manager.dart';
import 'module_chat/repository/chat/chat_repository.dart';
import 'module_chat/service/chat/char_service.dart';
import 'module_chat/ui/active_chats/active_chats.dart';
import 'module_chat/ui/screens/chat_page/chat_page.dart';
import 'module_home/ui/screen/home_screen/home_screen.dart';
import 'module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart';
import 'module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'module_persistence/sharedpref/shared_preferences_helper.dart';
import 'module_profile/manager/profile/profile.manager.dart';
import 'module_profile/prefs_helper/profile_prefs_helper.dart';
import 'module_profile/repository/profile/profile.repository.dart';
import 'module_profile/service/profile/profile.service.dart';
import 'module_profile/state_manager/edit_profile.dart';
import 'module_profile/state_manager/user_profile.dart';
import 'module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'module_profile/ui/screen/user_profile/user_profile.dart';
import 'module_services/repository/services_repository.dart';
import 'module_services/service/services_service.dart';
import 'module_services/services_module.dart';
import 'module_services/state_manager/add_service_state_manager.dart';
import 'module_services/state_manager/service_screen_state_manager.dart';
import 'module_services/ui/screen/add_service_screen.dart';
import 'module_services/ui/screen/services_screen.dart';
import 'module_settings/settings_module.dart';
import 'module_settings/ui/settings_page/settings_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'module_swap/manager/swap_manager.dart';
import 'module_swap/repository/swap_repository.dart';
import 'module_swap/service/swap_service.dart';
import 'module_swap/state_manager/create_swap_state_manager.dart';
import 'module_swap/state_manager/update_swap_state_manager.dart';
import 'module_swap/ui/screen/Create_swap_screen.dart';
import 'module_theme/pressistance/theme_preferences_helper.dart';
import 'module_upload/manager/upload_manager/upload_manager.dart';
import 'module_upload/repository/upload_repository/upload_repository.dart';
import 'module_upload/service/image_upload/image_upload_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await timeago.setLocaleMessages('ar', timeago.ArMessages());
  await timeago.setLocaleMessages('en', timeago.EnMessages());
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    FlutterError.onError = (FlutterErrorDetails details) async {
      new Logger().error('Main', details.toString(), StackTrace.current);
    };
    await runZoned<Future<void>>(() async {
      // Your App Here
      runApp(MyApp(
        AuthorizationModule(
            LoginScreen(LoginStateManager(AuthService(
                AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))))),
            null),
        ServicesModule(
            AddServiceScreen(AddServiceStateManager(ServicesService(
                ServicesRepository(AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))))))),
            EditServiceScreen(EditServiceStateManager(ServicesService(
                ServicesRepository(AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient())))))))),
        ProfileModule(
            EditProfileScreen(EditProfileStateManager(
                ImageUploadService(UploadManager(UploadRepository())),
                ProfileService(
                  ProfileManager(ProfileRepository(
                      ApiClient(),
                      AuthService(AuthPrefsHelper(),
                          AuthManager(AuthRepository(ApiClient()))))),
                  ProfilePreferencesHelper(),
                  AuthService(AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))),
                  ServicesService(ServicesRepository(AuthService(
                      AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))))),
                ))),
            UserProfileScreen(UserProfileStateManager(ProfileService(
              ProfileManager(ProfileRepository(
                  ApiClient(),
                  AuthService(AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))))),
              ProfilePreferencesHelper(),
              AuthService(
                  AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
              ServicesService(ServicesRepository(AuthService(AuthPrefsHelper(),
                  AuthManager(AuthRepository(ApiClient()))))),
            )))),
        HomeModule(HomeScreen(
            SettingsScreen(
              AuthService(
                  AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
              LocalizationService(LocalizationPreferencesHelper()),
              AppThemeDataService(ThemePreferencesHelper()),
              ProfileService(
                ProfileManager(ProfileRepository(
                    ApiClient(),
                    AuthService(AuthPrefsHelper(),
                        AuthManager(AuthRepository(ApiClient()))))),
                ProfilePreferencesHelper(),
                AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))),
                ServicesService(ServicesRepository(AuthService(
                    AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))))),
              ),
              // FireNotificationService(
              //     NotificationsPrefsHelper(),
              //     ProfileService(
              //       ProfileManager(ProfileRepository(
              //           ApiClient(),
              //           AuthService(AuthPrefsHelper(),
              //               AuthManager(AuthRepository(ApiClient()))))),
              //       ProfilePreferencesHelper(),
              //       AuthService(AuthPrefsHelper(),
              //           AuthManager(AuthRepository(ApiClient()))),
              //       ServicesService(ServicesRepository(AuthService(
              //           AuthPrefsHelper(),
              //           AuthManager(AuthRepository(ApiClient()))))),
              //     ),
              //     NotificationRepo(
              //         ApiClient(),
              //         AuthService(AuthPrefsHelper(),
              //             AuthManager(AuthRepository(ApiClient()))))),
            ),
            ServicesScreen(ServiceScreenStateManager(ServicesService(
                ServicesRepository(AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))))))),
            UserProfileScreen(UserProfileStateManager(ProfileService(
              ProfileManager(ProfileRepository(
                  ApiClient(),
                  AuthService(AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))))),
              ProfilePreferencesHelper(),
              AuthService(
                  AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
              ServicesService(ServicesRepository(AuthService(AuthPrefsHelper(),
                  AuthManager(AuthRepository(ApiClient()))))),
            ))),
            AuthService(
                AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
            ActiveChatsScreen(),
            NotificationScreen(
              NotificationsStateManager(
                  NotificationService(
                      SwapService(
                          SwapManager(SwapRepository(
                            AuthService(AuthPrefsHelper(),
                                AuthManager(AuthRepository(ApiClient()))),
                          )),
                          ServicesService(ServicesRepository(AuthService(
                              AuthPrefsHelper(),
                              AuthManager(AuthRepository(ApiClient())))))),
                      AuthService(AuthPrefsHelper(),
                          AuthManager(AuthRepository(ApiClient())))),
                  SwapService(
                      SwapManager(SwapRepository(
                        AuthService(AuthPrefsHelper(),
                            AuthManager(AuthRepository(ApiClient()))),
                      )),
                      ServicesService(ServicesRepository(AuthService(
                          AuthPrefsHelper(),
                          AuthManager(AuthRepository(ApiClient()))))))),
              ProfileService(
                ProfileManager(ProfileRepository(
                    ApiClient(),
                    AuthService(AuthPrefsHelper(),
                        AuthManager(AuthRepository(ApiClient()))))),
                ProfilePreferencesHelper(),
                AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))),
                ServicesService(ServicesRepository(AuthService(
                    AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))))),
              ),
              AuthService(
                  AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
            ))),

        SettingsModule(SettingsScreen(
          AuthService(
              AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
          LocalizationService(LocalizationPreferencesHelper()),
          AppThemeDataService(ThemePreferencesHelper()),
          ProfileService(
            ProfileManager(ProfileRepository(
                ApiClient(),
                AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))))),
            ProfilePreferencesHelper(),
            AuthService(
                AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))),
            ServicesService(ServicesRepository(AuthService(
                AuthPrefsHelper(), AuthManager(AuthRepository(ApiClient()))))),
          ),
        )),
        SwapModule(
            SwapsScreen(ListSwapStateManager(SwapService(
                SwapManager(SwapRepository(
                  AuthService(AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))),
                )),
                ServicesService(ServicesRepository(AuthService(
                    AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient())))))))),
            CreateSwapScreen(CreateSwapStateManager(SwapService(
                SwapManager(SwapRepository(
                  AuthService(AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))),
                )),
                ServicesService(ServicesRepository(AuthService(
                    AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient())))))))),
            UpdateSwapScreen(UpdateSwapStateManager(SwapService(
              SwapManager(SwapRepository(
                AuthService(AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient()))),
              )),
              ServicesService(ServicesRepository(AuthService(AuthPrefsHelper(),
                  AuthManager(AuthRepository(ApiClient()))))),
            )))),
        ChatModule(ChatPage(ChatPageBloc(ChatService(ChatManager(ChatRepository())),SwapService(
          SwapManager(SwapRepository(
            AuthService(AuthPrefsHelper(),
                AuthManager(AuthRepository(ApiClient()))),
          )),
          ServicesService(ServicesRepository(AuthService(AuthPrefsHelper(),
              AuthManager(AuthRepository(ApiClient()))))),
        ),NotificationService(
            SwapService(
                SwapManager(SwapRepository(
                  AuthService(AuthPrefsHelper(),
                      AuthManager(AuthRepository(ApiClient()))),
                )),
                ServicesService(ServicesRepository(AuthService(
                    AuthPrefsHelper(),
                    AuthManager(AuthRepository(ApiClient())))))),
            AuthService(AuthPrefsHelper(),
                AuthManager(AuthRepository(ApiClient())))),),AuthService(AuthPrefsHelper(),
            AuthManager(AuthRepository(ApiClient()))),SwapService(
          SwapManager(SwapRepository(
            AuthService(AuthPrefsHelper(),
                AuthManager(AuthRepository(ApiClient()))),
          )),
          ServicesService(ServicesRepository(AuthService(AuthPrefsHelper(),
              AuthManager(AuthRepository(ApiClient()))))),
        ),ImageUploadService(UploadManager(UploadRepository())),),AuthGuard(SharedPreferencesHelper()))
        ,
      ));
    }, onError: (error, stackTrace) {
      new Logger().error(
          'Main', error.toString() + stackTrace.toString(), StackTrace.current);
    });
  });
}

@provide
class MyApp extends StatefulWidget {
  final AuthorizationModule _authorizationModule;
  final ProfileModule _profileModule;
  final HomeModule _homeModule;
  final ServicesModule _servicesModule;
  final SettingsModule _settingsModule;
  final SwapModule _swapModule;
  final ChatModule _chatModule;

  MyApp(this._authorizationModule, this._servicesModule, this._profileModule,
      this._homeModule, this._settingsModule, this._swapModule,this._chatModule);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutes = {};
    fullRoutes.addAll(widget._authorizationModule.getRoutes());
    fullRoutes.addAll(widget._profileModule.getRoutes());
    fullRoutes.addAll(widget._homeModule.getRoutes());
    fullRoutes.addAll(widget._servicesModule.getRoutes());
    fullRoutes.addAll(widget._settingsModule.getRoutes());
    fullRoutes.addAll(widget._swapModule.getRoutes());
    fullRoutes.addAll(widget._chatModule.getRoutes());

    return getConfiguratedApp(
      fullRoutes,
    );
  }

  Widget getConfiguratedApp(
    Map<String, WidgetBuilder> fullRoutesList,
  ) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barter',
        routes: fullRoutesList,
        initialRoute: HomeRoutes.HOME_ROUTE);
  }
}

// @provide
// class MyApp extends StatefulWidget {
//   final AppThemeDataService _themeDataService;
//   final LocalizationService _localizationService;
//   final ChatModule _chatModule;
//   final InitAccountModule _initAccountModule;
//   final SettingsModule _settingsModule;
//   final AuthorizationModule _authorizationModule;
//   final SplashModule _splashModule;
//   final ProfileModule _profileModule;
//   final FireNotificationService _fireNotificationService;
//   final HomeModule _homeModule;
//   final ServicesModule _servicesModule;

//   MyApp(
//     this._themeDataService,
//     this._localizationService,
//     this._chatModule,
//     this._splashModule,
//     this._fireNotificationService,
//     this._initAccountModule,
//     this._settingsModule,
//     this._authorizationModule,
//     this._servicesModule,
//     this._profileModule,
//     this._homeModule,

//   );

//   @override
//   State<StatefulWidget> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   static FirebaseAnalytics analytics = FirebaseAnalytics();
//   static FirebaseAnalyticsObserver observer =
//       FirebaseAnalyticsObserver(analytics: analytics);

//   String lang;
//   ThemeData activeTheme;
//   bool authorized = false;

//   @override
//   void initState() {
//     super.initState();
//     widget._fireNotificationService.init();
//     widget._localizationService.localizationStream.listen((event) {
//       timeago.setDefaultLocale(event);
//       setState(() {});
//     });

//     widget._themeDataService.darkModeStream.listen((event) {
//       activeTheme = event;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Map<String, WidgetBuilder> fullRoutes = {};
//     fullRoutes.addAll(widget._authorizationModule.getRoutes());
//     fullRoutes.addAll(widget._splashModule.getRoutes());
//     fullRoutes.addAll(widget._chatModule.getRoutes());
//     fullRoutes.addAll(widget._profileModule.getRoutes());
//     fullRoutes.addAll(widget._homeModule.getRoutes());
//     fullRoutes.addAll(widget._servicesModule.getRoutes());

//     return FutureBuilder(
//       initialData: ThemeData.light(),
//       future: widget._themeDataService.getActiveTheme(),
//       builder: (BuildContext context, AsyncSnapshot<ThemeData> themeSnapshot) {
//         return FutureBuilder(
//             initialData: 'en',
//             future: widget._localizationService.getLanguage(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<String> langSnapshot) {
//               return getConfiguratedApp(
//                 fullRoutes,
//                 themeSnapshot.data,
//                 langSnapshot.data,
//               );
//             });
//       },
//     );
//   }

//   Widget getConfiguratedApp(
//     Map<String, WidgetBuilder> fullRoutesList,
//     ThemeData theme,
//     String activeLanguage,
//   ) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorObservers: <NavigatorObserver>[observer],
//       locale: Locale.fromSubtags(
//         languageCode: activeLanguage,
//       ),
//       localizationsDelegates: [
//         S.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       theme: theme,
//       supportedLocales: S.delegate.supportedLocales,
//       title: 'Barter',
//       routes: fullRoutesList,
//       initialRoute: HomeRoutes.HOME_ROUTE,
//     );
//   }
// }
