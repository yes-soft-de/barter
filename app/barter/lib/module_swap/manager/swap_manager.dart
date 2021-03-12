
import 'package:inject/inject.dart';
import 'package:barter/module_swap/repository/swap_repository.dart';

@provide
class SwapManager  {
    final SwapRepository _repository;
    SwapManager(this._repository);

    Future<dynamic> getSwaps() => _repository.getSwaps();
}