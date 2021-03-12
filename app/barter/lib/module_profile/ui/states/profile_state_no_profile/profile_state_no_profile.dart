import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:barter/module_profile/ui/widget/profile_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateNoProfile extends ProfileState {
  ProfileRequest request;
  ProfileStateNoProfile(EditProfileScreenState screenState, this.request)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    request ??= ProfileRequest.empty();
    return ProfileFormWidget(
      onProfileSaved: (request) {
        screenState.saveProfile(request);
      },
      onImageUpload: (request) {
        screenState.uploadImage(request);
      },
    );
  }
}
