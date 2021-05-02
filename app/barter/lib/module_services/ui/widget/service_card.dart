import 'package:barter/consts/urls.dart';
import 'package:barter/module_profile/profile_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemberCard extends StatelessWidget {
  final String type;
  final int serviceId;
  final String name;
  final String image;
  final double rate;
  final int servicesNumber;

  MemberCard(this.type, this.serviceId, this.name, this.image, this.rate,
      this.servicesNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: 140,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.orangeAccent,
                        size: 12,
                      ),
                      Text(
                        '${rate}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text('${type}')
                ],
              ),
            ),
            Container(
              height: 80,
              child: (image == null)
                  ? Image.asset('assets/images/logo.png')
                  : Image.network(
                      image.contains('http')
                          ? image
                          : Urls.IMAGES_ROOT + image,
                      errorBuilder: (e, r, t) {
                        return Image.asset('assets/images/logo.png');
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${name}',
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileRoutes.PROFILE_SCREEN,
                      arguments: serviceId);
                },
                color: Theme.of(context).primaryColorLight,
                child: Text(
                  '${servicesNumber} Services',

                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
