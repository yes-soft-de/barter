import 'package:barter/module_services/model/member_model.dart';

class MembersModel {
  final List<MemberModel> personalAccounts;
  final List<MemberModel> companyAccounts;

  MembersModel(this.personalAccounts, this.companyAccounts);
}