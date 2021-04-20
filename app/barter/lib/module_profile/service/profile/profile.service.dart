import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
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

  ProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
    this._servicesService,
  );

  Future<ProfileModel> getMyProfile() async {
    ProfileResponseModel responseModel = await _manager.getMyProfile();
   String role =  responseModel.role =='"ROLE_COMPANY"'?'Company':'User';
    return ProfileModel(
      firstName: responseModel.userName,
      lastName: responseModel.lastName,
      image: responseModel.image,
      type: role,
      services: ServiceFactory.getServicesList(5),
    );
  }

  Future<bool> updateProfile(ProfileRequest profileRequest) async {
    if (profileRequest.type == 'company') {
      profileRequest.roles = ['"ROLE_COMPANY"'];
    } else {
      profileRequest.roles = ['"ROLE_USER"'];
    }
    var profileUpdated = await _manager.updateProfile(profileRequest);
    return profileUpdated != null;
  }

  Future<dynamic> getProfileFromServiceId(String serviceId) async {
    var service = await _servicesService.getServiceById(serviceId);

    var profile = await _manager.getUserProfile(service.userId);
    return profile;
  }
}
