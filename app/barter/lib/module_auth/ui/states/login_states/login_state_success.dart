import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:barter/module_auth/presistance/auth_prefs_helper.dart';
import 'package:barter/module_auth/repository/auth/auth_repository.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:flutter/material.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/module_profile.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/repository/profile/profile.repository.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:barter/module_profile/state_manager/edit_profile.dart';
import 'package:barter/module_profile/state_manager/user_profile.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_services/repository/services_repository.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_upload/manager/upload_manager/upload_manager.dart';
import 'package:barter/module_upload/repository/upload_repository/upload_repository.dart';
import 'package:barter/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/material.dart';

class LoginStateSuccess extends LoginState {
  LoginStateSuccess(LoginScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlutterLogo(),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          padding: EdgeInsets.all(16),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              // Navigator.of(context)
              //     .pushReplacementNamed(ProfileRoutes.EDIT_PROFILE_SCREEN);
                  AuthService authService = AuthService(
      AuthPrefsHelper(),
      AuthManager(AuthRepository(ApiClient())),
    );
    ProfileService profileService = ProfileService(
      ProfileManager(ProfileRepository(ApiClient(), authService)),
      ProfilePreferencesHelper(),
      authService,
      ServicesService(ServicesRepository()),
    );

    
   ProfileModule profileModule = ProfileModule(
        EditProfileScreen(EditProfileStateManager(
            ImageUploadService(UploadManager(UploadRepository())),
            profileService)),
        UserProfileScreen(UserProfileStateManager(profileService)));


    Navigator.push(context,MaterialPageRoute(builder: (context)=>profileModule.editProfileScreen) );
            });
          },
          child: Text('Welcome to Barter'),
        )
      ],
    );
  }
}
