
import 'package:inject/inject.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:barter/module_swap/ui/state/swap_state.dart';
import 'package:rxdart/rxdart.dart';

@provide
class SwapStateManager  {
    SwapService _service;
    final stateStream = PublishSubject<SwapState>();
    SwapStateManager(this._service);


}