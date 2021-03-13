import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/model/activity_model/activity_model.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/request/branch/create_branch_request.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/create_branch_response.dart';
import 'package:barter/module_profile/response/profile_response.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_services/utils/service_factory.dart';
import 'package:inject/inject.dart';

@provide
class ProfileService {
  final ProfileManager _manager;
  final ProfilePreferencesHelper _preferencesHelper;
  final ServicesService _servicesService;
  final AuthService _authService;

  ProfileService(this._manager,
      this._preferencesHelper,
      this._authService,
      this._servicesService,);

  Future<ProfileModel> getMyProfile() async {
    return ProfileModel(
      firstName: 'Mohammad',
      lastName: 'Al Kalaleeb',
      image: 'as',
      services: ServiceFactory.getServicesList(5),
    );
    // return _manager.getMyProfile();
  }

  Future<bool> updateProfile(ProfileRequest profileRequest) async {
    var profileUpdated = await _manager.updateProfile(profileRequest);
    return profileUpdated != null;
  }

  Future<dynamic> getProfileFromServiceId(String serviceId) async {
    var service = await _servicesService.getServiceById(serviceId);

    var profile = await _manager.getUserProfile(service.userId);
    return profile;
  }
}
