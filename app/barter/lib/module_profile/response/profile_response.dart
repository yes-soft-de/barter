class ProfileResponse {
  String statusCode;
  String msg;
  ProfileResponseModel data;

  ProfileResponse({this.statusCode, this.msg, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null
        ? new ProfileResponseModel.fromJson(json['Data'])
        : null;
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

class ProfileResponseModel {
  String image;
  String firstName;
  String lastName;
  String location;
  String phone;
  String type;

  ProfileResponseModel(
      {this.image,
      this.firstName,
      this.lastName,
      this.location,
      this.phone,
      this.type});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    location = json['location'];
    phone = json['phone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['type'] = this.type;
    return data;
  }
}
