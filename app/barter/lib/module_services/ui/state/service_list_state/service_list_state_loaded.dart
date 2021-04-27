import 'package:barter/module_services/model/members_model.dart';
import 'package:barter/module_services/ui/screen/services_screen.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state.dart';
import 'package:barter/module_services/ui/widget/service_card.dart';
import 'package:barter/module_services/ui/widget/yes_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ServiceListStateLoaded extends ServiceListState {
  final MembersModel members;

  ServiceListStateLoaded(ServicesScreen screen, this.members) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YesCarousel(cards: <Widget>[
              Text('Card 01 of the carouser'),
              Text('Card 02 of the carouser'),
              Text('Card 03 of the carouser'),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New companies you may like',
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _getCompanyCards(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'People in this service',
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _getPersonalCards(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPersonalCards() {
    var cards = <Widget>[];
    members.personalAccounts.forEach((element) {
      cards.add(MemberCard(
        'Personal',
        element.serviceId,
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
    members.companyAccounts.forEach((element) {
      cards.add(MemberCard(
        'Company',
        element.serviceId,
        element.name,
        element.image,
        element.rate,
        element.servicesNumber,
      ));
    });
    return cards;
  }
}
