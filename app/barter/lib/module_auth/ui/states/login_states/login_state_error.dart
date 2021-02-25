import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:barter/module_auth/ui/states/login_states/login_state.dart';
import 'package:barter/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:barter/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:barter/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:flutter/material.dart';

class LoginStateError extends LoginState {
  String errorMsg;
  UserRole userType = UserRole.ROLE_OWNER;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool loading = false;

  String email;
  String password;

  LoginStateError(LoginScreen screen, this.errorMsg, this.email, this.password)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 96,
          child: UserTypeSelector(
            currentUserType: userType,
            onUserChange: (newType) {
              userType = newType;
              screen.refresh(this);
              loginTypeController.jumpToPage(userType.index);
            },
          ),
        ),
        Expanded(
            child: PageView(
          controller: loginTypeController,
          onPageChanged: (pos) {
            userType = UserRole.values[pos];
          },
          children: [
            PhoneLoginWidget(
              codeSent: false,
              onLoginRequested: (phone) {
                loading = true;
                screen.refresh(this);
                screen.loginCaptain(phone);
              },
              onRetry: () {},
              onConfirm: (confirmCode) {
                loading = true;
                screen.refresh(this);
                screen.confirmCaptainSMS(confirmCode);
              },
            ),
            EmailPasswordForm(
              onLoginRequest: (email, password) {
                loading = true;
                screen.refresh(this);
                screen.loginOwner(
                  email,
                  password,
                );
              },
            ),
          ],
        )),
        MediaQuery.of(context).viewInsets.bottom == 0
            ? Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMsg,
                    maxLines: 3,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
