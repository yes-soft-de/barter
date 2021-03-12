import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_swap/ui/state/swap_state_init.dart';
import 'package:barter/module_swap/ui/state/swap_state_loaded.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:barter/module_swap/ui/state/swap_state.dart';
import 'package:rxdart/rxdart.dart';

@provide
class SwapStateManager {
  final SwapService _service;
  final stateStream = PublishSubject<SwapState>();

  SwapStateManager(this._service);

  void getMySwaps(SwapScreen screen) {
    stateStream.add(SwapStateInit(screen));
    _service.getSwapList().then((swaps) {
      stateStream.add(SwapStateLoaded(screen, swaps));
    });
  }
}
