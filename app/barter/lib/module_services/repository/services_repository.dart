import 'package:barter/consts/urls.dart';
import 'package:barter/module_auth/exceptions/auth_exception.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_services/request/add_service_request.dart';
import 'package:barter/module_services/response/category_list_response.dart';
import 'package:barter/module_services/response/create_service_response.dart';
import 'package:barter/module_services/response/members_response.dart';
import 'package:barter/module_services/response/service_details_response.dart';
import 'package:barter/module_services/response/service_response.dart';
import 'package:inject/inject.dart';

@provide
class ServicesRepository {
  final client = ApiClient();
  final AuthService _authService;
  ServicesRepository(this._authService);
  Future<CreateServiceResponse> createService(AddServiceRequest request) async {
    await _authService.refreshToken();
    String token;
    try {
      token = await _authService.getToken();
    } catch (e) {
      throw UnauthorizedException('Get Profile Null Token');
    }
    if (token == null) throw UnauthorizedException('Get Profile Null Token');

    var response = await client.post(Urls.CREATE_SERVICE_API, request.toJson(),
    headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return null;

    return CreateServiceResponse.fromJson(response);
  }

  Future<ServicesResponse> getServices() async {
  await _authService.refreshToken();
    String token;
    try {
      token = await _authService.getToken();
    } catch (e) {
      throw UnauthorizedException('Get Profile Null Token');
    }
    if (token == null) throw UnauthorizedException('Get Profile Null Token');

     
    var result = await client.get(Urls.SERVICES_API,  headers: {'Authorization': 'Bearer ' + token},);
    if (result == null) {
      return null;
    } else {
      return ServicesResponse.fromJson(result);

    }
  }

  Future<ServicesDetailsResponse> getService(String serviceId) async {
    
    var result = await client.get('${Urls.SERVICES_BY_ID_API}/$serviceId');
    if (result == null) {
      return null;
    } else {
      return ServicesDetailsResponse.fromJson(result);
    }
  }

  Future<MembersResponse> getMembers() async {
    var result = await client.get(Urls.MEMBERS_API);
    if (result == null) {
      return null;
    } else {
      return MembersResponse.fromJson(result);
    }
  }

  Future<CategoryListResponse> getCategories() async {
    var result = await client.get(Urls.CATEGORY_LIST_API);
    if (result == null) {
      return null;
    } else {
      return CategoryListResponse.fromJson(result);
    }
  }
}