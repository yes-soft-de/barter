import 'package:barter/module_services/ui/widget/create_service_form.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CreateServiceForm(onServiceAdd: (ServiceModel ) {  }, categories: ['S'],)
            ],
          ),
        ),
      ),
    );
  }
}
