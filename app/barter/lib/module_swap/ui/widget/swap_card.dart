import 'package:barter/module_swap/model/swap_model.dart';
import 'package:flutter/material.dart';

class SwapCard extends StatelessWidget {
  final SwapModel model;
  SwapCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/logo.jpg',
                image: model.userOneImage,
                imageErrorBuilder: (e, s, o) {
                  return Image.asset('assets/images/logo.jpg');
                },
              ),
            ),
            Text(
              model.userOneImage,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 56,
            width: 56,
            child: Icon(Icons.swap_calls_sharp),
          ),
        ),
        Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/logo.jpg',
                image: model.userOneImage,
                imageErrorBuilder: (e, s, o) {
                  return Image.asset('assets/images/logo.jpg');
                },
              ),
            ),
            Text(
              model.userOneImage,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}