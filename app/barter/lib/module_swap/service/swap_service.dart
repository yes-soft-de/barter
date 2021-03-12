
import 'package:inject/inject.dart';
import 'package:barter/module_swap/manager/swap_manager.dart';

@provide
class SwapService  {
    SwapManager _manager;

    SwapService(this._manager);

    Future getSwapList() {

    }
}