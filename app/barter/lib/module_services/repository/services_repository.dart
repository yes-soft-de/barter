import 'package:barter/consts/urls.dart';
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

  Future<CreateServiceResponse> createService(AddServiceRequest request) async {
    var response = await client.post(Urls.CREATE_SERVICE_API, request.toJson());

    if (response == null) return null;

    return CreateServiceResponse.fromJson(response);
  }

  Future<ServicesResponse> getServices() async {
    var result = await client.get(Urls.SERVICES_API);
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