import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/state_manager/add_service_state_manager.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state.dart';
import 'package:barter/module_services/ui/state/add_service_state/add_service_state_loading.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class AddServiceScreen extends StatefulWidget {
  final AddServiceStateManager _stateManager;
  AddServiceScreen(this._stateManager);

  void addService(ServiceModel serviceModel) {
    _stateManager.addService(this, serviceModel);
  }

  @override
  State<StatefulWidget> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  AddServiceState _currentState;

  @override
  void initState() {
    widget._stateManager.stateStream.stream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
    widget._stateManager.getCategories(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentState ??= AddServiceStateLoading(widget);
    return Scaffold(
        appBar: AppBar(
          title: Text('Add New Service'),
        ),
        body: _currentState.getUI(context),
    );
  }
}
