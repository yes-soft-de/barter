class UserProfileResponse {
  String statusCode;
  String msg;
  UserProfileResponseModel data;

  UserProfileResponse({this.statusCode, this.msg, this.data});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null
        ? new UserProfileResponseModel.fromJson(json['Data'])
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

class UserProfileResponseModel {
  String image;
  String userName;
  String role;
  String lastName;
  String location;
  String phone;
  List<Data> services;

  UserProfileResponseModel(
      {this.image,
      this.userName,
      this.lastName,
      this.location,
      this.phone,
      this.role,
      this.services});

  UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    userName = json['userName'];
    lastName = json['lastName'];
    location = json['location'];
    phone = json['phone'];
    role = json['role'];
    services = (json['services'] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['services'] = this.services;
    return data;
  }
}

class Data {
  int id;
  String serviceTitle;
  String description;
  Duration duration;
  int categoryID;
  String categoryName;
  Duration activeUntil;
  bool enabled;
  String avgRating;
  List<String> tags;
  String userName;
  String userImage;

  Data(
      {this.id,
      this.serviceTitle,
      this.description,
      this.duration,
      this.categoryID,
      this.categoryName,
      this.activeUntil,
      this.enabled,
      this.avgRating,
      this.tags,
      this.userName,
      this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceTitle = json['serviceTitle'];
    description = json['description'];
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    activeUntil = json['activeUntil'] != null
        ? new Duration.fromJson(json['activeUntil'])
        : null;
    enabled = json['enabled'];
    avgRating = json['avgRating'];
    tags = json['tags'].cast<String>();
    userName = json['userName'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceTitle'] = this.serviceTitle;
    data['description'] = this.description;
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    if (this.activeUntil != null) {
      data['activeUntil'] = this.activeUntil.toJson();
    }
    data['enabled'] = this.enabled;
    data['avgRating'] = this.avgRating;
    data['tags'] = this.tags;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    return data;
  }
}

class Duration {
  Timezone timezone;
  int offset;
  int timestamp;

  Duration({this.timezone, this.offset, this.timestamp});

  Duration.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String name;
  List<Transitions> transitions;
  Location location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = new List<Transitions>();
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Transitions {
  int ts;
  String time;
  int offset;
  bool isdst;
  String abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String countryCode;
  int latitude;
  int longitude;
  String comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}
