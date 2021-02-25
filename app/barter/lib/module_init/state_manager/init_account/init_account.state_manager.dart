import 'package:barter/consts/branch.dart';
import 'package:barter/generated/l10n.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_init/model/branch/branch_model.dart';
import 'package:barter/module_init/service/init_account/init_account.service.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:barter/module_profile/response/create_branch_response.dart';
import 'package:barter/module_profile/service/profile/profile.service.dart';
import 'package:barter/module_upload/service/image_upload/image_upload_service.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

@provide
class dynamicManager {
  final InitAccountService _initAccountService;
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<dynamic> _stateSubject = PublishSubject<dynamic>();

  Stream<dynamic> get stateStream => _stateSubject.stream;

  dynamicManager(
    this._initAccountService,
    this._profileService,
    this._authService,
    this._uploadService,
  );
}
