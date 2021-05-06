import 'package:barter/module_swap/response/swap_response.dart';

class CreateSwapRequest {
  String date;
  String userIdOne;
  String userIdTwo;
  List<int> swapItemsOne;
  List<int> swapItemsTwo;
  String cost;
  String roomID;
  String status;
  CreateSwapRequest({this.date,this.cost,this.status,this.roomID,this.swapItemsTwo,this.swapItemsOne});
  CreateSwapRequest.empty();

  CreateSwapRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    userIdOne = json['userIdOne'];
    userIdTwo = json['userIdTwo'];
    swapItemsOne = json['swapItemsOne'] ;
    swapItemsTwo = json['swapItemsTwo'];
    cost = json['cost'];
    roomID = json['roomID'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['swapItemsOne'] = swapItemsOne ;
    data['swapItemsTwo'] = swapItemsTwo;
    data['cost'] = cost;
    data['roomID'] = roomID;
    data['status'] = status;
    return data;
  }
}


