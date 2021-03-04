class Urls {
  static const String DOMAIN = 'http://34.72.57.5';
  static const String BASE_API = DOMAIN + '/html/public';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';

  static const SIGN_UP_API = BASE_API + '/user';
  static const PROFILE_API = BASE_API + '/userprofile';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';


  static const UPLOAD_API = BASE_API + '/uploadfile';

  static const PACKAGES_API = BASE_API + '/packages';
  static const SUBSCRIPTION_API = BASE_API + '/subscription';

  static const APPOINTMENT_API = BASE_API + '/dating';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
}
