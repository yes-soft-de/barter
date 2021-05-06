import 'package:barter/module_swap/swap_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String rate;

  ServiceCard({
    this.id,
    this.description,
    this.name,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 2,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${name}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),

                  Container(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Available For SS',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Text(
                    rate == null ? '0.0' : '${rate}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.orangeAccent,
                      size: 16,
                    ),
                  ),
                  Spacer(),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(SwapRoutes.CREATE_SWAP_ROUTE,arguments: id);
                    },
                    child: Text(
                      'Request'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$description',
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
