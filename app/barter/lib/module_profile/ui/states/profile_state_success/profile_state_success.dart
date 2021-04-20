import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:barter/module_auth/presistance/auth_prefs_helper.dart';
import 'package:barter/module_auth/repository/auth/auth_repository.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_chat/ui/screens/active_chats/active_chats.dart';
import 'package:barter/module_home/home_routes.dart';
import 'package:barter/module_home/ui/screen/home_screen/home_screen.dart';
import 'package:barter/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart';
import 'package:barter/module_localization/service/localization_service/localization_service.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:barter/module_notifications/repository/notification_repo.dart';
import 'package:barter/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/repository/profile/profile.repository.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:barter/module_profile/state_manager/user_profile.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:barter/module_services/repository/services_repository.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_services/state_manager/service_screen_state_manager.dart';
import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_settings/ui/settings_page/settings_page.dart';
import 'package:barter/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:barter/module_theme/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileStateSaveSuccess extends ProfileState {
  ProfileStateSaveSuccess(EditProfileScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.solidHeart,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
          Text('Save Success'),//S.of(context).saveSuccess),
          RaisedButton(
            onPressed: () {
            Navigator.push(context ,MaterialPageRoute(
              builder: (context){    
           return  homeeeeee; 
              },


             
            ));
           // Navigator.of(context).pushNamed(HomeRoutes.HOME_ROUTE);
            },
            child: Text('Next'),//S.of(context).next),
          ),
        ],
      ),
    );
  }
}


 // Route For Test
//////////////////////////////////////////
///
         ServicesService servicesService = ServicesService(ServicesRepository());
            AuthService authService =    AuthService(AuthPrefsHelper(),AuthManager(AuthRepository(ApiClient())));
        ProfileService profileService = ProfileService(ProfileManager(ProfileRepository(ApiClient(),authService)),ProfilePreferencesHelper(),authService,servicesService);
         HomeScreen  homeeeeee =   HomeScreen(SettingsScreen(authService,LocalizationService(LocalizationPreferencesHelper()),AppThemeDataService(ThemePreferencesHelper()),profileService,FireNotificationService(NotificationsPrefsHelper(),profileService,NotificationRepo(ApiClient(),authService)),),
               ServicesScreen(ServiceScreenStateManager(servicesService)),
                UserProfileScreen(UserProfileStateManager(profileService)),
                 authService,
                  ActiveChatsScreen()
                  ); 