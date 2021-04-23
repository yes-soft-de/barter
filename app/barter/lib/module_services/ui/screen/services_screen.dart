import 'package:barter/module_services/state_manager/service_screen_state_manager.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state.dart';
import 'package:barter/module_services/ui/state/service_list_state/service_list_state_loading.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ServicesScreen extends StatefulWidget {
  final ServiceScreenStateManager _manager;

  ServicesScreen(this._manager);

  @override
  State<StatefulWidget> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  ServiceListState _currentState;

  @override
  void initState() {
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    widget._manager.getServices(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentState ??= ServiceListStateLoading(widget);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('NA', style: TextStyle(color: Colors.white),),
          ),
        ),
        title: Text('Barter'),
      ),
      body: _currentState.getUI(context),
    );
  }
}
