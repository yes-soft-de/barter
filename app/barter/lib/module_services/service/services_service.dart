import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/utils/service_factory.dart';
import 'package:inject/inject.dart';

@provide
class ServicesService {
  Future<List<ServiceModel>> getServices() async {
    return ServiceFactory.getServicesList(10);
  }

  Future<dynamic> addService() async {
    return true;
  }
}
