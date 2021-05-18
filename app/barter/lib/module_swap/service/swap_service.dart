import 'dart:async';
import 'package:barter/consts/keys.dart';
import 'package:barter/module_auth/service/auth_service/auth_service.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/request/create_swap_request.dart';
import 'package:barter/module_swap/request/update_swap_request.dart';
import 'package:barter/module_swap/response/swap_response.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/manager/swap_manager.dart';
import 'package:uuid/uuid.dart';

@provide
class SwapService {
  final SwapManager _manager;
  final ServicesService _servicesService;
 final AuthService _authService ;
  SwapService(this._manager, this._servicesService,this._authService);

  Future<List<SwapItemsModel>> getMyItems() async {
    List<ServiceModel> services = await _servicesService.getServices();
    List<SwapItemsModel> items = [];
    services.forEach((element) {
      print('------------------ my item');
      print(element.id);
      items.add(SwapItemsModel(
        id: element.id,
        itemTitle: element.name,
      ));
    });
    return items;
  }

  Future<List<SwapItemsModel>> getTargetItems(serviceId) async {
    List<ServiceModel> services =
        await _servicesService.getServicesByServiceId(serviceId);
    List<SwapItemsModel> items = [];
    services.forEach((element) {
      print('------------------ target item');
      print(element.id);
      items.add(SwapItemsModel(
        id: element.id,
        itemTitle: element.name,
      ));
    });
    return items;
  }

  Future<List<SwapModel>> getSwapList() async {
    SwapListResponse response = await _manager.getMySwaps();

    if (response == null) return null;

    List<SwapModel> list = [];
    response.data.forEach((element) {
      list.add(SwapModel(
          id: element.id.toString(),
          userOneName: element.userOneName,
          userTowName: element.userTwoName,
          swapItemsOne: List.generate(
              element.swapItemsOne.length,
              (index) => SwapItemsModel(
                  id: element.swapItemsOne[index].id,
                  itemTitle: element.swapItemsOne[index].serviceTitle)),
          swapItemsTow: List.generate(
              element.swapItemsTwo.length,
              (index) => SwapItemsModel(
                  id: element.swapItemsTwo[index].id,
                  itemTitle: element.swapItemsTwo[index].serviceTitle)),
          userOneImage: element.userOneImage,
          userTowImage: element.userTwoImage,
          accepted: true,
          status: element.status));
    });
    return list;
  }

  Future<SwapModel> updateSwap(SwapModel swapModel) async {
    UpdateSwapRequest request = UpdateSwapRequest(
      swapID: swapModel.id,
      swapItemsOne: swapModel.swapItemsOne.map((e) => int.parse(e.id)).toList(),
      swapItemsTwo: swapModel.swapItemsTow.map((e) => int.parse(e.id)).toList(),
      cost: " ",
      status: swapModel.status,
      roomID: swapModel.chatRoomId,
      date: DateTime.now().toString(),
    );
    var swapResponse = await _manager.updateSwap(request);
    if (swapResponse == null) {
      return null;
    }
    return SwapModel();
  }

  Future<SwapModel> createSwap(SwapModel swapModel) async {
    var swapResponse = await _manager.createSwap(
      CreateSwapRequest(
        swapItemsOne:
            swapModel.swapItemsOne.map((e) => int.parse(e.id)).toList(),
        swapItemsTwo:
            swapModel.swapItemsTow.map((e) => int.parse(e.id)).toList(),
        cost: " ",
        status: ApiKeys.KEY_SWAP_STATUS_INITIATED,
        date: DateTime.now().toString(),
      ),
    );
    if (swapResponse == null) {
      return null;
    }

    return SwapModel();
  }

  Future<SwapModel> getSwapById(id) async {

    SwapListResponse response = await _manager.getSwapById(id);
    if (response == null) return null;

   String uId = await _authService.userID;
    List<SwapModel> list = [];
    response.data.forEach((element) {
      list.add(SwapModel(
          id: element.id.toString(),
          userOneName: element.userOneName,
          userTowName: element.userTwoName,
          swapItemsOne:uId== element.userIdOne? List.generate(
              element.swapItemsOne.length,
              (index) => SwapItemsModel(
                  id: element.swapItemsOne[index].id,
                  itemTitle: element.swapItemsOne[index].serviceTitle)):
          List.generate(
              element.swapItemsTwo.length,
                  (index) => SwapItemsModel(
                  id: element.swapItemsOne[index].id,
                  itemTitle: element.swapItemsOne[index].serviceTitle))

        ,
          swapItemsTow: uId== element.userIdOne? List.generate(
              element.swapItemsTwo.length,
              (index) => SwapItemsModel(
                  id: element.swapItemsTwo[index].id,
                  itemTitle: element.swapItemsTwo[index].serviceTitle)):
          List.generate(
              element.swapItemsOne.length,
                  (index) => SwapItemsModel(
                  id: element.swapItemsTwo[index].id,
                  itemTitle: element.swapItemsTwo[index].serviceTitle))
        ,
          userOneImage: element.userOneImage,
          userTowImage: element.userTwoImage,
          accepted: true,
          ));
    });
    return list[0];
  }

  Future<List<SwapModel>> getSwapRequests() async {
    SwapListResponse response = await _manager.getMySwaps();

    if (response == null) return null;

    //List<String> s = [ApiKeys.KEY_SWAP_STATUS_INITIATED,ApiKeys.KEY_SWAP_STATUS_COMPLETE,ApiKeys.KEY_SWAP_STATUS_STARTED,ApiKeys.KEY_SWAP_STATUS_SECOND_USER_ACCEPTED];

    Map<String, SwapModel> swapMap = <String, SwapModel>{};
    String roomId;
    response.data.forEach((element) {
      SwapModel e = SwapModel(
        id: element.id.toString(),
        userOneName: element.userOneName,
        userTowName: element.userTwoName,
        userOneId: element.userIdOne,
        userTowId: element.userIdTwo,
        swapItemsOne: List.generate(
            element.swapItemsOne.length,
            (index) => SwapItemsModel(
                id: element.swapItemsOne[index].id,
                itemTitle: element.swapItemsOne[index].serviceTitle)),
        swapItemsTow: List.generate(
            element.swapItemsTwo.length,
            (index) => SwapItemsModel(
                id: element.swapItemsTwo[index].id,
                itemTitle: element.swapItemsTwo[index].serviceTitle)),
        userOneImage: element.userOneImage,
        userTowImage: element.userTwoImage,
        accepted: element.status == 'accept' ? true : false,
        status: element.status,
        chatRoomId: element.roomID
      );

      swapMap[roomId] = e;
    });

    return swapMap.values.toList();
  }
}
