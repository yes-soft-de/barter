import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:barter/module_profile/ui/widget/profile_form.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateDirtyProfile extends ProfileState {
  ProfileRequest request;
  List<ServiceModel> services;
  ProfileStateDirtyProfile(
      EditProfileScreenState screenState, this.request, this.services)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ProfileFormWidget(
      request: request,
      services: services,
      onProfileSaved: (request) {
        screenState.saveProfile(request);
      },
      onImageUpload: (request) {
        screenState.uploadImage(request, services);
      },
    );
  }
}
