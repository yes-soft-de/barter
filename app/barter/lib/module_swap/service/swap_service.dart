import 'package:barter/module_swap/model/swap_model.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/manager/swap_manager.dart';

@provide
class SwapService {
  final SwapManager _manager;

  SwapService(this._manager);

  Future<List<SwapModel>> getSwapList() async {
    await _manager.getSwaps();
    // TODO(Implement This: map swap response to swap model list)
    return [];
  }
}
