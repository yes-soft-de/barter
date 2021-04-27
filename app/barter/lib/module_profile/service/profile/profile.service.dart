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

  Future<ProfileModel> getMyProfile() async {
    ProfileResponseModel responseModel = await _manager.getMyProfile();
    String role = responseModel.role == 'ROLE_USER' ? 'User' : 'Company';
    List<ServiceModel> _services = await _servicesService.getServices();
    return ProfileModel(
        firstName: responseModel.userName,
        lastName: responseModel.lastName,
        image: responseModel.image,
        type: role,
        services: _services);
  }
 
 Future<ProfileModel> getUserProfile(serviceId) async{
   UserProfileResponseModel responseModel = await _manager.getUserProfile(serviceId);
    String role = responseModel.role == 'ROLE_USER' ? 'User' : 'Company';
    if(serviceId == null){
      List<ServiceModel> _services = await _servicesService.getServices();
      return ProfileModel(
          firstName: responseModel.userName,
          lastName: responseModel.lastName,
          image: responseModel.image,
          type: role,
          services: _services);
    }
    else{
      List<ServiceModel> _services =  [];
      responseModel.services.forEach((element) {
        ServiceModel serviceModel = ServiceModel(
          id: element.id.toString(),
          name: element.serviceTitle,
          description: element.description,
          categoryId: element.categoryID.toString(),
          rate: element.avgRating
        );
        _services.add(serviceModel);
      });
      return ProfileModel(
          firstName: responseModel.userName,
          lastName: responseModel.lastName,
          image: responseModel.image,
          type: role,
          services: _services);
    }

 }

  Future<bool> updateProfile(ProfileRequest profileRequest) async {
    print(profileRequest.type);
    if (profileRequest.type == 'company') {
      profileRequest.roles = ["ROLE_COMPANY"];
    } else {
      profileRequest.roles = ["ROLE_USER"];
    }
    var profileUpdated = await _manager.updateProfile(profileRequest);
    return profileUpdated != null;
  }

  
}
