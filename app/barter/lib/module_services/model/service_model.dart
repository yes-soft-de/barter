import 'package:barter/module_auth/enums/user_type.dart';

class ServiceModel {
  final UserRole type;
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String image;
  final String rate;
  final int servicesNumber;
  final DateTime activeUntil;

  ServiceModel({
    this.type,
    this.id,
    this.name,
    this.image,
    this.rate,
    this.activeUntil,
    this.categoryId,
    this.description,
    this.servicesNumber,
  });
}
