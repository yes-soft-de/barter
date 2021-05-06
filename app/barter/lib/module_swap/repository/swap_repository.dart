import 'package:barter/consts/urls.dart';
import 'package:barter/module_auth/exceptions/auth_exception.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_swap/request/create_swap_request.dart';
import 'package:barter/module_swap/request/update_swap_request.dart';
import 'package:barter/module_swap/response/create_swap_response.dart';
import 'package:barter/module_swap/response/get_swap_response.dart';
import 'package:barter/module_swap/response/swap_response.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_network/http_client/http_client.dart';

@provide
class SwapRepository {
  final _apiClient = new ApiClient();
  final AuthService _authService;
  SwapRepository(this._authService);

  Future<SwapListResponse> getSwaps() async {
    var response = await _apiClient.get(Urls.SWAP_LIST_API,);
    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }

  Future<CreateSwapResponse> createSwaps(CreateSwapRequest request) async {
    String token;
    try {
      await _authService.refreshToken();
      token = await _authService.getToken();
    } catch (e) {
      throw UnauthorizedException('Get Profile Null Token');
    }
    if (token == null) throw UnauthorizedException('Get Profile Null Token');

    var response =
        await _apiClient.post(Urls.CREATE_SWAP_API, request.toJson(),  headers: {'Authorization': 'Bearer ' + token});

    if (response == null) return null;
    return CreateSwapResponse.fromJson(response);
  }

  Future<CreateSwapResponse> updateSwaps(UpdateSwapRequest request) async {

    print('===================== start update from repository =================');
    print(request.swapID);
    print(request.toJson());
    String token;
    try {
      await _authService.refreshToken();
      token = await _authService.getToken();
    } catch (e) {
      throw UnauthorizedException('Get Profile Null Token');
    }
    if (token == null) throw UnauthorizedException('Get Profile Null Token');

    var response = await _apiClient.put(
        '${Urls.UPDATE_SWAP_API}', request.toJson(),headers: {'Authorization': 'Bearer ' + token});
    print('===================== end update from repository =================');

    if (response == null) return null;
    return CreateSwapResponse.fromJson(response);
  }

  Future<SwapListResponse> getSwapById(swapId)async {
    var response =
    await _apiClient.get('${Urls.SWAP_BY_ID_API}/$swapId',);

    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }

  Future<SwapListResponse> getMySwapa()async {
    String token;
    try {
      await _authService.refreshToken();
      token = await _authService.getToken();
    } catch (e) {
      throw UnauthorizedException('Get Profile Null Token');
    }
    if (token == null) throw UnauthorizedException('Get Profile Null Token');

    var response =
    await _apiClient.get('${Urls.SWAP_BY_USER_ID_API}',headers: {'Authorization': 'Bearer ' + token});

    if (response == null) return null;
    return SwapListResponse.fromJson(response);
  }
}

