import 'package:barter/module_auth/enums/user_type.dart';

class ServiceModel {
  final UserRole type;
  final String name;
  final String image;
  final double rate;
  final int servicesNumber;

  ServiceModel({
    this.type,
    this.name,
    this.image,
    this.rate,
    this.servicesNumber,
  });
}
