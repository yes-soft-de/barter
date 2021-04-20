class ProfileRequest {
  String image;
  String userName;
  List<String> roles;
  String lastName;
  String location;
  String phone;
  String type;

  ProfileRequest.empty();

  ProfileRequest(
      {this.image,
      this.userName,
      this.lastName,
      this.location,
      this.phone,
      this.type,
      this.roles
      });

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    userName = json['userName'];
    lastName = json['lastName'];
    location = json['location'];
    phone = json['phone'];
    type = json['type'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['roles'] =this.roles ;
    return data;
  }
}
