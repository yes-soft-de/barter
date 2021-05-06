
import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/request/update_swap_request.dart';
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';
import 'package:barter/module_swap/ui/screen/Update_swap_screen.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state_error.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state_got_swap.dart';
import 'package:barter/module_swap/ui/state/update_swap_state/update_swap_state_success.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:rxdart/rxdart.dart';

@provide
class UpdateSwapStateManager {
  final SwapService _service;

  final stateStream = PublishSubject<UpdateSwapState>();

  UpdateSwapStateManager(this._service);

  void updateSwap(UpdateSwapScreen screen , SwapModel swapModel){
    _service.updateSwap(swapModel).then((value){
      if(value != null){
        stateStream.add(UpdateSwapStateSuccess(screen));
      }else{
        print(value);
        stateStream.add(UpdateSwapStateError(screen, 'Error update The Swap'));
      }
    });
  }
  void getSwapById(UpdateSwapScreen screenState, id) {
    _service.getSwapById(id).then((value) {
      if(value != null){
        _getItems(value.swapItemsTow[0].id).then((items) {
          if(items!=null){
            stateStream.add(UpdateSwapStateGotSwap(screenState,
              UpdateSwapRequest(
                swapID:id,
                swapItemsOne: value.swapItemsOne.map((e) =>int.parse(e.id)).toList() ,
                swapItemsTwo:value.swapItemsTow.map((e) =>int.parse(e.id)).toList() ,
              ),
                myItems: items['myItems'],
                targetItems: items['targetItems'],
            ));
          }else{
            stateStream.add(UpdateSwapStateError(screenState, 'Error swap items loading!'));
          }
        });
      }else{
        stateStream.add(UpdateSwapStateError(screenState, 'Error loading Swap detial!'));
      }
    });

  }
 Future<Map<String , List<SwapItemsModel>>> _getItems(id){
   return    _service.getMyItems().then((value1) {
     if (value1 != null) {
      return  _service.getTargetItems(id).then((value2) {
         if (value2 != null) {
          return {
            'myItems':value1,
            'targetItems':value2
          };
         } else {
          return null;
         }
       });
     } else {
       return null;
     }
   });
    return null;
 }

}
