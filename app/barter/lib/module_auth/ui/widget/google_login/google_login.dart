import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginWidget extends StatelessWidget {
  final Function() onGoogleLoginRequested;
  GoogleLoginWidget({this.onGoogleLoginRequested});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.google),
      onPressed: () {
        onGoogleLoginRequested();
      },
    );
  }
}
