import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class UserProfileStateManager {
  final stateSubject = PublishSubject();

  void getUserInfo(String serviceId) {

  }
}