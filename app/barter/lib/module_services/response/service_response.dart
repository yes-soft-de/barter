class ServicesResponse {
  String statusCode;
  String msg;
  List<Data> data;

  ServicesResponse({this.statusCode, this.msg, this.data});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
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
  List<String> tags;
  Null userName;
  Null userImage;

  Data(
      {this.id,
        this.serviceTitle,
        this.description,
        this.duration,
        this.categoryID,
        this.categoryName,
        this.activeUntil,
        this.enabled,
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
