import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_loaded.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class UserProfileStateManager {
  final stateSubject = PublishSubject<UserProfileState>();

  final ProfileService _service;
  UserProfileStateManager(this._service);

  void getUserInfoByServiceId(UserProfileScreen screen, int serviceId) {

    if (serviceId.toString() == null) {
      _service.getMyProfile().then((value) {
        stateSubject.add(UserProfileStateLoaded(screen, value));
      });
    } else {
        _service.getUserProfile(serviceId).then((value) {
        stateSubject.add(UserProfileStateLoaded(screen, value));
      });
    }
  }
}
