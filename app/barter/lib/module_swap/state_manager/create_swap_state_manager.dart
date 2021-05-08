import 'package:barter/module_services/service/services_service.dart';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/ui/screen/Create_swap_screen.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/create_swap_state_items_loaded.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/create_swap_state_success.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state_error.dart';
import 'package:barter/module_swap/ui/state/create_swap_state/swap_state_init.dart';
import 'package:inject/inject.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:rxdart/rxdart.dart';

@provide
class CreateSwapStateManager {
  final SwapService _service;

  final stateStream = PublishSubject<CreateSwapState>();

  CreateSwapStateManager(this._service);


  void createSwap(CreateSwapScreen screen , SwapModel swapModel){
    _service.createSwap(swapModel).then((value){
      if(value != null){
        stateStream.add(CreateSwapStateSuccess(screen));
      }else{
        print(value);
        stateStream.add(CreateSwapStateError(screen, 'Error Send The Swap'));
      }
    });
  }

  void getItems(CreateSwapScreen screen,serviceId){
    stateStream.add(SwapStateInit(screen));
    _service.getMyItems().then((myItems) {
      if(myItems !=null){
        _service.getTargetItems(serviceId).then((targetItems){
          if(targetItems != null){
            stateStream.add(
                CreateSwapStateItemsAdded(
                  screen,
                    serviceId:serviceId,
                  myItems:myItems,
                  targetItems: targetItems
                )
            );
          }else{
            stateStream.add(CreateSwapStateError(screen, 'Error loading target services!'));
          }
        });
      }else{
        stateStream.add(CreateSwapStateError(screen, 'Error loading my services!'));
      }
    });}



}
