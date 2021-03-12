import 'package:barter/consts/urls.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:barter/module_profile/ui/widget/service_card.dart';
import 'package:flutter/material.dart';

class UserProfileStateLoaded extends UserProfileState {
  ProfileModel model;

  UserProfileStateLoaded(UserProfileScreen screen, this.model) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                  height: 72,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1613506543439-e31c1e58852b?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDIzfHRvd0paRnNrcEdnfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
                              ),
                              fit: BoxFit.fitWidth,
                              onError: (e, s) {
                                return AssetImage('assets/images/logo.png');
                              }),
                        ),
                      ),
                    ),
                  )),
            ),
            Text(
              '${model.firstName} ${model.lastName}',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _getUserMetrics(context),
            ),
            _getServiceCards(),
          ],
        ),
      ),
    );
  }

  Widget _getUserMetrics(BuildContext context) {
    var children = <Widget>[];
    children.add(Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal'),
              Text('22 Bartered'),
            ],
          ),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: Text(
                'Request'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )),
      ],
    ));
    return Column(
      children: children,
    );
  }

  Widget _getServiceCards() {
    var children = <Widget>[];
    model.services.forEach((e) {
      var card = new ServiceCard(
        name: e.name,
        description: e.image,
        rate: e.rate,
      );
      children.add(card);
    });
    return Column(
      children: children,
    );
  }
}
