import 'package:barter/consts/urls.dart';
import 'package:barter/module_swap/response/swap_response.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/utils/logger/logger.dart';

@provide
class SwapRepository {
  final _apiClient = new ApiClient();

  Future<SwapListResponse> getSwaps() async {
    var response = await _apiClient.get(Urls.SWAP_LIST_API);

    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }
}
