import 'package:barter/module_auth/exceptions/auth_exception.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/profile_response.dart';
import 'package:barter/module_profile/response/user_profile_response.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/service/services_service.dart';
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


  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
  }

  Future<ProfileModel> get profile async {
    var username = await _preferencesHelper.getUsername();
    var image = await _preferencesHelper.getImage();
    return ProfileModel(firstName: username, image: image,);
  }
  // ignore: missing_return
  Future<ProfileModel> getMyProfile() async {
    try {
      ProfileResponseModel responseModel = await _manager.getMyProfile();
      String role = responseModel.role == 'ROLE_USER' ? 'User' : 'Company';

      // for laze loaded
      // List<ServiceModel> _services = await _servicesService.getServices();

      // for eager loaded
      List<ServiceModel> _services = [];
      responseModel.services.forEach((element) {
        ServiceModel serviceModel = ServiceModel(
            id: element.id.toString(),
            name: element.serviceTitle,
            description: element.description,
            categoryId: element.categoryID.toString(),
            rate: element.avgRating);
        _services.add(serviceModel);
      });
      return ProfileModel(
          firstName: responseModel.userName,
          lastName: responseModel.lastName,
          image: responseModel.image,
          type: role,
          services: _services);
    } catch (e) {
      if (e is UnauthorizedException) rethrow;
    }
  }

  // ignore: missing_return
  Future<ProfileModel> getUserProfile(serviceId) async {
    try {
      UserProfileResponseModel responseModel =
          await _manager.getUserProfile(serviceId);
      String role = responseModel.role == 'ROLE_USER' ? 'User' : 'Company';
      List<ServiceModel> _services = [];
      responseModel.services.forEach((element) {
        ServiceModel serviceModel = ServiceModel(
            id: element.id.toString(),
            name: element.serviceTitle,
            description: element.description,
            categoryId: element.categoryID.toString(),
            rate: element.avgRating);
        _services.add(serviceModel);
      });
      return ProfileModel(
          firstName: responseModel.userName,
          lastName: responseModel.lastName,
          image: responseModel.image,
          type: role,
          services: _services);
    } catch (e) {
      if (e is UnauthorizedException) rethrow;
    }
  }

  Future<bool> updateProfile(ProfileRequest profileRequest) async {
    if (profileRequest.type == 'company') {
      profileRequest.roles = ["ROLE_COMPANY"];
    } else {
      profileRequest.roles = ["ROLE_USER"];
    }
    var profileUpdated = await _manager.updateProfile(profileRequest);
    return profileUpdated != null;
  }
}
