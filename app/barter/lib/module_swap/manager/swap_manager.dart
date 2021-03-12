
import 'package:barter/module_swap/response/swap_response.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/repository/swap_repository.dart';

@provide
class SwapManager  {
    final SwapRepository _repository;
    SwapManager(this._repository);

    Future<SwapListResponse> getSwaps() => _repository.getSwaps();
}