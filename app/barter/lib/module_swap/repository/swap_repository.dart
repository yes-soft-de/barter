
import 'package:barter/consts/urls.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_network/http_client/http_client.dart';
import 'package:barter/utils/logger/logger.dart';

@provide
class SwapRepository  {
    final _apiClient = new ApiClient();

    Future<dynamic> getSwaps() {
        return _apiClient.get(Urls.SWAP_LIST_API);
    }
}