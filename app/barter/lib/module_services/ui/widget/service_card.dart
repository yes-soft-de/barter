import 'package:barter/consts/urls.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceCard extends StatelessWidget {
  final String type;
  final String name;
  final String image;
  final double rate;
  final int servicesNumber;

  ServiceCard(this.type, this.name, this.image, this.rate, this.servicesNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: Card(
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    '$image'.contains('http')
                        ? '$image'
                        : Urls.IMAGES_ROOT + image,
                  ),
                  fit: BoxFit.cover,
                  onError: (e, s) {
                    return AssetImage('assets/images/logo.jpg');
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${name}',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // TODO: Navigate to Profile
                },
                color: Theme.of(context).primaryColorLight,
                child: Text(
                  '${servicesNumber} Services',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
