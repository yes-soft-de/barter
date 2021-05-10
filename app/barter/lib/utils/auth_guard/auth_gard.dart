import 'package:barter/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:inject/inject.dart';

@provide
@singleton
class AuthGuard {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthGuard(this._sharedPreferencesHelper);

  Future<bool> isLoggedIn() async {
    var user = _sharedPreferencesHelper.getUserUID();
    return user != null;
  }
}
