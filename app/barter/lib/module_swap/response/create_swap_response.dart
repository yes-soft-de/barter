import 'package:barter/module_swap/response/swap_response.dart';

class CreateSwapResponse {
  String statusCode;
  String msg;
  Data data;

  CreateSwapResponse({this.statusCode, this.msg, this.data});

  CreateSwapResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userIdOne;
  String userIdTwo;
  List<int> swapItemsOne;
  List<int> swapItemsTwo;
  int id;
  Date date;
  String userOneName;
  String userOneImage;
  String userTwoName;
  String userTwoImage;
  String cost;
  String roomID;
  String status;

  Data(
      {this.userIdOne,
      this.userIdTwo,
      this.swapItemsOne,
      this.swapItemsTwo,
      this.id,
      this.date,
      this.userOneName,
      this.userOneImage,
      this.userTwoName,
      this.userTwoImage,
      this.cost,
      this.roomID,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    userIdOne = json['userIdOne'];
    userIdTwo = json['userIdTwo'];
    if (json['swapItemsOne'] != null) {
      swapItemsOne = json['swapItemsOne'].cast<int>();
    }
    if (json['swapItemsTwo'] != null) {
      swapItemsTwo = json['swapItemsTwo'].cast<int>();
    }
    id = json['id'] != null ? int.parse(json['id']) : json['id'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    userOneName = json['userOneName'];
    userOneImage = json['userOneImage'];
    userTwoName = json['userTwoName'];
    userTwoImage = json['userTwoImage'];
    cost = json['cost'];
    roomID = json['roomID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userIdOne'] = this.userIdOne;
    data['userIdTwo'] = this.userIdTwo;
    if (this.swapItemsOne != null) {
      data['swapItemsOne'] = this.swapItemsOne;
    }
    if (this.swapItemsTwo != null) {
      data['swapItemsTwo'] = this.swapItemsTwo;
    }
    data['id'] = this.id;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['userOneName'] = this.userOneName;
    data['userOneImage'] = this.userOneImage;
    data['userTwoName'] = this.userTwoName;
    data['userTwoImage'] = this.userTwoImage;
    data['cost'] = this.cost;
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    return data;
  }
}
