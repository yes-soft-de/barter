import 'package:barter/module_swap/state_manager/list_swap_state_manager.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state_loading.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SwapsScreen extends StatefulWidget {
  final ListSwapStateManager _manager;

  SwapsScreen(this._manager);

  @override
  State<StatefulWidget> createState() => _SwapsScreenState();
}

class _SwapsScreenState extends State<SwapsScreen> {
  SwapListState _currentState;

  @override
  void initState() {
    widget._manager.stateStream.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    widget._manager.getMySwaps(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentState ??= SwapListStateLoading(widget);
    return Scaffold(
      appBar: AppBar(
        title: Text('Barter'),
      ),
      body: _currentState.getUI(context),
    );
  }
}
