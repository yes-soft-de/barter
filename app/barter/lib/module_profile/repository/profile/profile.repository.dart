import 'package:barter/consts/urls.dart';
import 'package:barter/module_auth/exceptions/auth_exception.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/profile_response.dart';
import 'package:barter/module_profile/response/user_profile_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
    this._apiClient,
    this._authService,
  );

  Future<ProfileResponseModel> getMyProfile() async {
    String token;
    try {
      await _authService.refreshToken();
      token = await _authService.getToken();
    } catch (e) {
      throw UnauthorizedException('Get Profile Null Token');
    }
    if (token == null) throw UnauthorizedException('Get Profile Null Token');
    dynamic response = await _apiClient.get(
      Urls.PROFILE_API,
      headers: {'Authorization': 'Bearer ' + token},
    );

    try {
      if (response == null) return null;
      return ProfileResponse.fromJson(response).data;
    } catch (e) {
      return null;
    }
  }

  Future<UserProfileResponseModel> getUserProfile(int serviceId) async {
    var response = await _apiClient.get('${Urls.PROFILE_API}/$serviceId');

    try {
      if (response == null) return null;
      return UserProfileResponse.fromJson(response).data;
    } catch (e) {
      return null;
    }
  }

  Future<ProfileResponse> updateProfile(ProfileRequest profileRequest) async {
    var token = await _authService.getToken();
    Map<String, dynamic> response;
    try {
      response = await _apiClient.put(
        Urls.PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
      if (response == null) return null;
      return ProfileResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
