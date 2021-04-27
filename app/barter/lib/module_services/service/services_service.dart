import 'package:barter/module_services/model/category_model.dart';
import 'package:barter/module_services/model/member_model.dart';
import 'package:barter/module_services/model/members_model.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/repository/services_repository.dart';
import 'package:barter/module_services/request/add_service_request.dart';
import 'package:barter/module_services/request/edit_service_request.dart';
import 'package:inject/inject.dart';

@provide
class ServicesService {
  final ServicesRepository _repository;

  ServicesService(this._repository);

  Future<List<ServiceModel>> getServices() async {
    var apiResponse = await _repository.getServices();
    var servicesList = <ServiceModel>[];
    apiResponse.data.forEach((element) {
      servicesList.add(ServiceModel(
          id: element.id.toString(),
          name: element.serviceTitle,
          description: element.description,
          rate: element.avgRating));
    });
    return servicesList;
  }

  Future<ServiceModel> getServiceById(String id) async {
    var apiResponse = await _repository.getService(id);
    return ServiceModel(
        id: apiResponse.data.id.toString(),
        name: apiResponse.data.serviceTitle,
        description: apiResponse.data.description);
  }

  Future<bool> editService(ServiceModel serviceModel) async {
    var request = EditServiceRequest(
        id: serviceModel.id,
        serviceTitle: serviceModel.name,
        description: serviceModel.description,
        activeUntil: serviceModel.activeUntil?.toIso8601String() ?? '-1',
        categoryID: serviceModel.categoryId,
        enabled: true,
        tags: []);

    var response = await _repository.editService(request);
    return response != null;
  }

  Future<MembersModel> getMembers() async {
    var apiResponse = await _repository.getMembers();
    var members = MembersModel([], []);
    apiResponse.data.personal.forEach((element) {
      members.personalAccounts.add(MemberModel(
          serviceId: element.serviceID,
          name: element.userName,
          image: element.image,
          rate: 0.6, //element.avgRating,
          servicesNumber: element.servicesNumber));
    });

    apiResponse.data.company.forEach((element) {
      members.companyAccounts.add(MemberModel(
          serviceId: element.serviceID,
          name: element.userName,
          image: element.image,
          rate: 0.5, // element.avgRating,
          servicesNumber: element.servicesNumber));
    });
    return members;
  }

  Future<bool> addService(ServiceModel serviceModel) async {
    var request = AddServiceRequest(
        serviceTitle: serviceModel.name,
        description: serviceModel.description,
        activeUntil: serviceModel.activeUntil?.toIso8601String() ?? '-1',
        categoryID: serviceModel.categoryId,
        enabled: true,
        tags: []);

    var response = await _repository.createService(request);
    return response != null;
  }

  Future<List<CategoryModel>> getCategories() async {
    var response = await _repository.getCategories();
    if (response == null) {
      return null;
    } else {
      var cats = <CategoryModel>[];
      response.data.forEach((element) {
        cats.add(
          CategoryModel(
            element.name,
            element.id.toString(),
          ),
        );
      });
      return cats;
    }
  }
}
