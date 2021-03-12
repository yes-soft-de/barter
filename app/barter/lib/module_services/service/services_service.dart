import 'package:barter/module_services/model/member_model.dart';
import 'package:barter/module_services/model/members_model.dart';
import 'package:barter/module_services/model/service_details_model.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/repository/services_repository.dart';
import 'package:barter/module_services/utils/service_factory.dart';
import 'package:inject/inject.dart';

@provide
class ServicesService {
  final ServicesRepository _repository;

  ServicesService(this._repository);

  Future<List<ServiceModel>> getServices() async {
    var apiResponse = await _repository.getServices();
    var servicesList = <ServiceModel>[];
    apiResponse.data.forEach((element) {
      servicesList
          .add(ServiceModel(name: element.userName, image: element.userImage));
    });
    return ServiceFactory.getServicesList(10);
  }

  Future<ServiceDetailsModel> getServiceById(String id) async {
    var apiResponse = await _repository.getService(id);
    return ServiceDetailsModel(apiResponse.data[0].id.toString());
  }

  Future<MembersModel> getMembers() async {
    var apiResponse = await _repository.getMembers();
    var members = MembersModel([], []);
    apiResponse.data.personal.forEach((element) {
      members.personalAccounts.add(MemberModel(
        name: element.userName,
        image: element.image,
      ));
    });

    apiResponse.data.company.forEach((element) {
      members.personalAccounts.add(MemberModel(
        name: element.userName,
        image: element.image,
      ));
    });
    return members;
  }

  Future<dynamic> addService() async {
    return true;
  }
}
