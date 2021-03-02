import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state.dart';
import 'package:barter/module_services/ui/widget/service_card.dart';
import 'package:barter/module_services/ui/widget/yes_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ServiceListStateLoaded extends ServiceListState {
  final List<ServiceModel> services;

  ServiceListStateLoaded(ServicesScreen screen, this.services) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YesCarousel(cards: <Widget> [
              Text('Card 01 of the carouser'),
              Text('Card 02 of the carouser'),
              Text('Card 03 of the carouser'),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('New companies you may like', textAlign: TextAlign.start,),
            ),
            Container(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _getPersonalCards(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('People in this service', textAlign: TextAlign.start,),
            ),
            Container(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _getCompanyCards(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPersonalCards() {
    var cards = <Widget>[];
    services.forEach((element) {
      if (element.type == UserRole.ROLE_COMPANY) return;
      cards.add(ServiceCard(
        'Company',
        element.name,
        element.image,
        element.rate,
        element.servicesNumber,
      ));
    });

    return cards;
  }

  List<Widget> _getCompanyCards() {
    var cards = <Widget>[];
    services.forEach((element) {
      if (element.type != UserRole.ROLE_COMPANY) return;
      cards.add(ServiceCard(
        'Personal',
        element.name,
        element.image,
        element.rate,
        element.servicesNumber,
      ));
    });

    return cards;
  }
}
