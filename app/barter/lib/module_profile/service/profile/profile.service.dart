import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_profile/manager/profile/profile.manager.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/profile_response.dart';
import 'package:barter/module_services/model/service_model.dart';
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

  //    static ServiceModel getNewService() {
  //   return ServiceModel(
  //     name: 'Service ' + Random().nextInt(10).toString(),
  //     rate: double.parse((Random().nextInt(10) + Random().nextDouble()).toStringAsPrecision(1)),
  //     image: 'https://images.unsplash.com/photo-1613506543439-e31c1e58852b?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDIzfHRvd0paRnNrcEdnfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //     servicesNumber: Random().nextInt(10),
  //     type: Random().nextBool() ? UserRole.ROLE_COMPANY : UserRole.ROLE_USER,
  //   );
  // }

  // static List<ServiceModel> getServicesList([int max = 10]) {
  //   var services = <ServiceModel>[];
  //   for(int i = 0 ; i < max ; i++) {
  //     services.add(getNewService());
  //   }
  //   return services;
  // }
    List<ServiceModel> _services  =await _servicesService.getServices();
    return ProfileModel(
      firstName: responseModel.userName,
      lastName: responseModel.lastName,
      image: responseModel.image,
      type: role,
      services:_services// ServiceFactory.getServicesList(5),
    );
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

  Future<dynamic> getProfileFromServiceId(String serviceId) async {
    var service = await _servicesService.getServiceById(serviceId);

    var profile = await _manager.getUserProfile(service.userId);
    return profile;
  }
}
