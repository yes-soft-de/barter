import 'dart:math';

import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_services/model/service_model.dart';

class ServiceFactory {
  static ServiceModel getNewService() {
    return ServiceModel(
      name: 'Service ' + Random().nextInt(10).toString(),
      rate: double.parse((Random().nextInt(10) + Random().nextDouble()).toStringAsPrecision(1)),
      image: 'https://images.unsplash.com/photo-1613506543439-e31c1e58852b?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDIzfHRvd0paRnNrcEdnfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      servicesNumber: Random().nextInt(10),
      type: Random().nextBool() ? UserRole.ROLE_COMPANY : UserRole.ROLE_USER,
    );
  }

  static List<ServiceModel> getServicesList([int max = 10]) {
    var services = <ServiceModel>[];
    for(int i = 0 ; i < max ; i++) {
      services.add(getNewService());
    }
    return services;
  }
}