import 'package:barter/module_auth/enums/auth_source.dart';
import 'package:barter/module_auth/enums/auth_status.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state_code_sent.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state_error.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state_success.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();

  String _email;
  String _password;

  LoginScreen _screenState;

  LoginStateManager(this._authService) {
    _authService.authListener.listen((event) {
      if (event == AuthStatus.AUTHORIZED) {
        _loginStateSubject.add(LoginStateSuccess(_screenState));
      } else {
        print('Null Screen');
      }
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  void loginCaptain(String phoneNumber, LoginScreen _loginScreenState) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loginStateSubject.add(LoginStateSuccess(_loginScreenState));
          break;
        case AuthStatus.CODE_SENT:
          _loginStateSubject.add(LoginStateCodeSent(_loginScreenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _loginStateSubject.add(LoginStateError(
              _loginScreenState, 'Code Timeout', _email, _password));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_loginScreenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject.add(LoginStateError(
          _loginScreenState, err.toString(), _email, _password));
    });

    _authService.verifyWithPhone(phoneNumber, UserRole.ROLE_COMPANY);
  }

  void loginOwner(
      String email, String password, LoginScreen _loginScreenState) {
    _email = email;
    _password = password;
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loginStateSubject
              .add(LoginStateSuccess(_loginScreenState ?? _screenState));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_loginScreenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject.add(LoginStateError(
          _loginScreenState, err.toString(), _email, _password));
    });
   
    _authService.signInWithEmailAndPassword('',
        email, password,UserRole.ROLE_COMPANY);
  }

  void confirmSMSCode(String smsCode, LoginScreen screenState) {
    _screenState = screenState;
    _authService.confirmWithCode(smsCode, UserRole.ROLE_COMPANY);
  }

  void loginViaGoogle(LoginScreen loginScreen) {
    _screenState = loginScreen;
    _authService.verifyWithGoogle(UserRole.ROLE_USER);
  }

  void refresh(LoginState state) {
    _loginStateSubject.add(state);
  }

  void retryPhone(LoginScreen screen) {
    _loginStateSubject.add(LoginStateInit(screen));
  }
}
