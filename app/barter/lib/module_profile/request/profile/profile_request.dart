class ProfileRequest {
  String image;
  String firstName;
  String lastName;
  String location;
  String phone;
  String type;

  ProfileRequest.empty();

  ProfileRequest(
      {this.image,
      this.firstName,
      this.lastName,
      this.location,
      this.phone,
      this.type});

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    location = json['location'];
    phone = json['phone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['type'] = this.type;
    return data;
  }
}
