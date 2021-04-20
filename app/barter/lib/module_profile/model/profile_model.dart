import 'package:barter/module_services/model/service_model.dart';

class ProfileModel {
  String firstName;
  String lastName;
  String phone;
  String image;
  String type;
  String location;
  List<ServiceModel> services;

  ProfileModel({
    this.firstName,
    this.lastName,
    this.location,
    this.image,
    this.phone,
    this.services,
    this.type
  });
}
