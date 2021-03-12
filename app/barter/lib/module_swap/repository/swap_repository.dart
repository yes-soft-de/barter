import 'package:barter/consts/urls.dart';
import 'package:barter/module_swap/request/create_swap_request.dart';
import 'package:barter/module_swap/request/update_swap_request.dart';
import 'package:barter/module_swap/response/swap_response.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_network/http_client/http_client.dart';

@provide
class SwapRepository {
  final _apiClient = new ApiClient();

  Future<SwapListResponse> getSwaps() async {
    var response = await _apiClient.get(Urls.SWAP_LIST_API);

    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }

  Future<SwapListResponse> createSwaps(CreateSwapRequest request) async {
    var response =
        await _apiClient.post(Urls.CREATE_SWAP_API, request.toJson());

    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }

  Future<SwapListResponse> updateSwaps(
      String swapId, UpdateSwapRequest request) async {
    var response = await _apiClient.put(
        '${Urls.UPDATE_SWAP_API}/$swapId', request.toJson());

    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }
}
