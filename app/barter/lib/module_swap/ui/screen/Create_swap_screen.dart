import 'dart:async';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state_init.dart';
import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:barter/module_swap/state_manager/create_swap_state_manager.dart';

@provide
class CreateSwapScreen extends StatefulWidget {
  final CreateSwapStateManager _stateManager;

  CreateSwapScreen(this._stateManager);

  @override
  _CreateSwapScreenState createState() => _CreateSwapScreenState();

  void addSwap(SwapModel swap) {
    _stateManager.createSwap(this, swap);
  }
}

class _CreateSwapScreenState extends State<CreateSwapScreen> {
  CreateSwapState _currentState;
  StreamSubscription _stateSubscription;

  @override
  void initState() {
    super.initState();
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentState = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == null) {
      String serviceId = ModalRoute.of(context).settings.arguments;
      widget._stateManager.getItems(widget, serviceId);
    }
    _currentState ??= SwapStateInit(widget);

    return Scaffold(
      appBar: AppBar(),
      body: _currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
    }
    super.dispose();
  }
}
