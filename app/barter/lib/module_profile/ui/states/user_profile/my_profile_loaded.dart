import 'package:barter/consts/urls.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:barter/module_profile/ui/widget/service_card.dart';
import 'package:barter/module_profile/ui/widget/service_edit_card.dart';
import 'package:flutter/material.dart';

class MyProfileStateLoaded extends UserProfileState {
  ProfileModel model;

  MyProfileStateLoaded(UserProfileScreen screen, this.model) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          child: (model.image == null)?
                              Image.asset('assets/images/logo.png'):
                          Image.network(model.image.contains('http')
                              ? '${model.image}'
                              : '${Urls.IMAGES_ROOT + model.image}',
                            fit: BoxFit.cover,
                            errorBuilder: (e,r,t){
                              return Image.asset('assets/images/logo.png');
                            },
                          ),
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          image: DecorationImage(
//                              image: NetworkImage(
//                              (model.image).contains('http')?
//                              model.image:
//                              Urls.IMAGES_ROOT + model.image
//                          //      'https://images.unsplash.com/photo-1613506543439-e31c1e58852b?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDIzfHRvd0paRnNrcEdnfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
//                              ),
//                              fit: BoxFit.fitWidth,
//                              onError: (e, s) {
//                                return AssetImage('assets/images/logo.png');
//                              }),
//                        ),
                        ),
                      ),
                    ),
                  )),
            ),
            Text(
              '${model.firstName} ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.bold
              ),
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
              Text((model.type == 'User')?'Personal Account':model.type +' Account'),
            ],
          ),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ProfileRoutes.EDIT_PROFILE_SCREEN);
              },
              child: Text(
                'Edit My Profile'.toUpperCase(),
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
    // There is data
    if (model.services.length > 0) {
      var children = <Widget>[];
      model.services.forEach((e) {
        var card = new ServiceEditCard(
          id: e.id.toString(),
          name: e.name,
          description: e.description,
          rate: e.rate,
        );
        children.add(card);
      });
      return Column(
        children: children,
      );
    } else
      return Center(
        child: Text('There are no services',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      );
  }
}
