import 'package:barter/consts/urls.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/module_services/response/members_response.dart';
import 'package:barter/module_services/response/service_response.dart';
import 'package:inject/inject.dart';

@provide
class ServicesRepository {
  Future<ServicesResponse> getServices() async {
    final client = ApiClient();
    var result = await client.get(Urls.SERVICES_API);
    if (result == null) {
      return null;
    } else {
      return ServicesResponse.fromJson(result);
    }
  }

  Future<MembersResponse> getMembers() async {
    final client = ApiClient();
    var result = await client.get(Urls.MEMBERS_API);
    if (result == null) {
      return null;
    } else {
      return MembersResponse.fromJson(result);
    }
  }
}