import 'package:barter/module_init/manager/init_account/init_account.manager.dart';
import 'package:barter/module_init/model/package/packages.model.dart';
import 'package:barter/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:barter/module_init/response/packages/packages_response.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountService {
  final InitAccountManager _manager;

  InitAccountService(
    this._manager,
  );

  Future<List<PackageModel>> getPackages() async {
    PackagesResponse response = await _manager.getPackages();
    if (response == null) return null;

    List<PackageModel> packages = [];

    response.data.forEach((element) {
      packages.add(new PackageModel(
        id: element.id,
        name: element.name,
        status: element.status,
        city: element.city,
        branch: element.branch,
        carCount: element.carCount,
        cost: element.cost,
        note: element.note,
        orderCount: element.orderCount,
      ));
    });

    return packages;
  }

  Future<bool> subscribePackage(int packageId) async =>
      await _manager.subscribePackage(packageId);

  Future<dynamic> createCaptainProfile(
      String name, String age, String image, String licence) {
    try {
      return _manager.createProfile(CreateCaptainProfileRequest(
          image, licence, int.tryParse(age ?? '28'), name));
    } catch (e) {
      return null;
    }
  }
}