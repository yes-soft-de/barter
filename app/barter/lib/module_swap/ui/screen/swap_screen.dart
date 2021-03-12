import 'dart:async';

import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:barter/module_swap/state_manager/swap_state_manager.dart';
import 'package:barter/module_swap/ui/state/swap_state.dart';
import 'package:barter/module_swap/ui/state/swap_state_init.dart';

@provide
class SwapScreen extends StatefulWidget {
  final SwapStateManager _stateManager;

  SwapScreen(this._stateManager);

  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  SwapState _currentState;
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
