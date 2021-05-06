import 'dart:async';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/state_manager/update_swap_state_manager.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state_init.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state_loading.dart';
import 'package:inject/inject.dart';
import 'package:flutter/material.dart';

@provide
class UpdateSwapScreen extends StatefulWidget {
  final UpdateSwapStateManager _stateManager;

  UpdateSwapScreen(this._stateManager);

  @override
  _UpdateSwapScreenState createState() => _UpdateSwapScreenState();

  void updateSwap(SwapModel swap) {
   _stateManager.updateSwap(this,swap);
  }
}

class _UpdateSwapScreenState extends State<UpdateSwapScreen> {
  UpdateSwapState _currentState;
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

    if(_currentState == null){
      String swapId = ModalRoute.of(context).settings.arguments;
      widget._stateManager.getSwapById(widget,swapId);
    }
    _currentState ??= SwapStateLoading(widget);

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
