import 'package:barter/consts/urls.dart';
import 'package:barter/module_profile/model/profile_model.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:barter/module_profile/ui/screen/user_profile/user_profile.dart';
import 'package:barter/module_profile/ui/states/user_profile/user_profile_state.dart';
import 'package:barter/module_profile/ui/widget/service_card.dart';
import 'package:barter/module_profile/ui/widget/service_edit_card.dart';
import 'package:barter/module_swap/swap_routes.dart';
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
            Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SwapRoutes.SWAPS_ROUTE,);
                },
                child: Text(
                  'Edit'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24.0,bottom: 24.0),
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
                    .pushNamed(SwapRoutes.SWAPS_ROUTE,);
              },
              child: Text(
                'My Swaps'.toUpperCase(),
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
