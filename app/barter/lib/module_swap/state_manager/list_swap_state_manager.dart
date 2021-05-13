import 'package:barter/module_swap/ui/screen/swap_screen.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state_error.dart';
import 'package:barter/module_swap/ui/state/swap_list_state/swap_list_state_loaded.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:rxdart/rxdart.dart';

@provide
class ListSwapStateManager {
  final SwapService _service;

  final stateStream = PublishSubject<SwapListState>();

  ListSwapStateManager(this._service);

  void getMySwaps(SwapsScreen screen) {
    _service.getSwapList().then((swaps) {
      if (swaps != null) {
        stateStream.add(SwapListStateLoaded(screen, swaps));
      } else {
        stateStream.add(SwapListStateError(screen, 'Erorr Swap Loaded!'));
      }
    });
  }
}
