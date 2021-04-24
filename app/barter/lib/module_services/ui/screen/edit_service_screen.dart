import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/state_manager/edit_service_state_manager.dart';
import 'package:barter/module_services/ui/state/edit_service_state/edit_service_state.dart';
import 'package:barter/module_services/ui/state/edit_service_state/edit_service_state_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditServiceScreen extends StatefulWidget {
  final EditServiceStateManager _stateManager;
  EditServiceScreen(this._stateManager);

  void editService(ServiceModel serviceModel) {
    _stateManager.editService(this, serviceModel);
  }

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  EditServiceState _currentState;

  @override
  void initState() {
    widget._stateManager.stateStream.stream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // To separate the recall from the work of the Flutter engine
    if (_currentState == null) {
      String _id = ModalRoute.of(context).settings.arguments;
      widget._stateManager.getServiceById(widget, _id);
    }

    _currentState ??= EditServiceStateLoading(widget);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Service'),
      ),
      body: _currentState.getUI(context),
    );
  }
}
