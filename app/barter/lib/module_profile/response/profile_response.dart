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
  String userName;
  String role;
  String lastName;
  String location;
  String phone;
  
  

  ProfileResponseModel(
      {this.image,
      this.userName,
      this.lastName,
      this.location,
      this.phone,
      this.role
      });

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    userName = json['userName'];
    lastName = json['lastName'];
    location = json['location'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}
