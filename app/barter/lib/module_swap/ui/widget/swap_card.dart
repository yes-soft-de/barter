import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/swap_routes.dart';
import 'package:flutter/material.dart';

class SwapCard extends StatelessWidget {
  final SwapModel model;
  SwapCard(this.model);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                        height: 65,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                child:model.userOneImage!= null? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/logo.png',
                                  image: model.userOneImage,
                                  fit: BoxFit.fill,
                                  imageErrorBuilder: (e, s, o) {
                                    return Image.asset('assets/images/logo.png');
                                  },
                                ):Image.asset('assets/images/logo.png'),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.userOneName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 56,
                    width: 56,
                    color: Theme.of(context).primaryColor,
                    child: Icon(Icons.swap_calls_sharp),
                  ),
                ),
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.userTowName,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Container(
                        height: 65,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                child:model.userTowImage !=null? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/logo.png',
                                  image: model.userTowImage,
                                  imageErrorBuilder: (_1, _2, _3) {
                                    return Image.asset('assets/images/logo.png');
                                  },
                                ):Image.asset('assets/images/logo.png'),
                              ),
                            ),
                          ),
                        )),

                  ],
                ),
                ListTile(
                  title: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context,SwapRoutes.UPDATE_SWAP_ROUTE,arguments: model.id,);
                    },
                    child: Text(
                      'Edit'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}