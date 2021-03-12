import 'package:barter/consts/urls.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProfileStateLoaded extends UserProfileState {
  ProfileModel model;

  UserProfileStateLoaded(UserProfileScreen screen, this.model) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.image}'.contains('http')
                            ? model.image
                            : Urls.IMAGES_ROOT + model.image,
                      ),
                      fit: BoxFit.fill,
                      onError: (e, s) {
                        return AssetImage('assets/images/logo.jpg');
                      }
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
        Text(
          '${model.name}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
