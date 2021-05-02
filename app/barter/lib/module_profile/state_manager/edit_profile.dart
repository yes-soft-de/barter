import 'package:barter/module_auth/exceptions/auth_exception.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:barter/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:barter/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:barter/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:barter/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state_no_profile/profile_state_no_profile.dart';
import 'package:barter/module_profile/ui/states/profile_state_success/profile_state_success.dart';
import 'package:barter/module_profile/ui/states/profile_state_unauthorized/profile_state_unauthorized.dart';
import 'package:barter/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EditProfileStateManager {
  final _stateSubject = PublishSubject<ProfileState>();
  final ImageUploadService _imageUploadService;
  final ProfileService _profileService;

  EditProfileStateManager(
    this._imageUploadService,
    this._profileService,
  );

  Stream<ProfileState> get stateStream => _stateSubject.stream;

  void uploadImage(
      EditProfileScreenState screenState, ProfileRequest request, services) {
    _imageUploadService.uploadImage(request.image).then((uploadedImageLink) {
      request.image = uploadedImageLink;
      _stateSubject
          .add(ProfileStateDirtyProfile(screenState, request, services));
    });
  }

  void submitProfile(
      EditProfileScreenState screenState, ProfileRequest request) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _profileService.updateProfile(request).then((value) {
      if (value) {
        _stateSubject.add(ProfileStateSaveSuccess(screenState));
      } else {
        print(request);
        _stateSubject.add(ProfileStateGotProfile(screenState, request, null));
      }
    });
  }

  void getProfile(EditProfileScreenState screenState) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _profileService.getMyProfile().then((value) {
      if (value == null) {
        _stateSubject.add(ProfileStateNoProfile(screenState, ProfileRequest()));
      } else {
        _stateSubject.add(
          ProfileStateGotProfile(
              screenState,
              ProfileRequest(
                userName: value.firstName,
                lastName: value.lastName,
                image: value.image,
                phone: value.phone,
                type: value.type,
              ),
              value.services),
        );
      }
    }).catchError((e) {
      debugPrint(e.toString());
      if (e is UnauthorizedException) {
        _stateSubject.add(ProfileStateUnauthorized(screenState));
        //  screenState.moveToLogin();
      }
    });
  }
}
