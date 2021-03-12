import 'package:barter/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:barter/module_profile/repository/profile/profile.repository.dart';
import 'package:barter/module_profile/request/branch/create_branch_request.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/create_branch_response.dart';
import 'package:barter/module_profile/response/get_records_response.dart';
import 'package:barter/module_profile/response/profile_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<ProfileResponseModel> getMyProfile() => _repository.getMyProfile();

  Future<ProfileResponseModel> getUserProfile(String userId) =>
      _repository.getUserProfile(userId);

  Future<ProfileResponse> updateProfile(ProfileRequest profileRequest) =>
      _repository.updateProfile(profileRequest);
}
