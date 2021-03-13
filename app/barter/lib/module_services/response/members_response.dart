class MembersResponse {
  String statusCode;
  String msg;
  Data data;

  MembersResponse({this.statusCode, this.msg, this.data});

  MembersResponse.fromJson(Map<String, dynamic> json) {
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
  List<Personal> personal;
  List<Company> company;

  Data({this.personal, this.company});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['personal'] != null) {
      personal = <Personal>[];
      json['personal'].forEach((v) {
        personal.add(new Personal.fromJson(v));
      });
    }
    if (json['company'] != null) {
      company = new List<Company>();
      json['company'].forEach((v) {
        company.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personal != null) {
      data['personal'] = this.personal.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  String userName;
  String image;
  String story;
  int serviceID;
  String serviceTitle;
  String description;
  int categoryID;
  ActiveUntil activeUntil;
  List<String> tags;

  Company(
      {this.userName,
      this.image,
      this.story,
      this.serviceID,
      this.serviceTitle,
      this.description,
      this.categoryID,
      this.activeUntil,
      this.tags});

  Company.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    image = json['image'];
    story = json['story'];
    serviceID = json['serviceID'];
    serviceTitle = json['serviceTitle'];
    description = json['description'];
    categoryID = json['categoryID'];
    activeUntil = json['activeUntil'] != null
        ? new ActiveUntil.fromJson(json['activeUntil'])
        : null;
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['story'] = this.story;
    data['serviceID'] = this.serviceID;
    data['serviceTitle'] = this.serviceTitle;
    data['description'] = this.description;
    data['categoryID'] = this.categoryID;
    if (this.activeUntil != null) {
      data['activeUntil'] = this.activeUntil.toJson();
    }
    data['tags'] = this.tags;
    return data;
  }
}

class ActiveUntil {
  Timezone timezone;
  int offset;
  int timestamp;

  ActiveUntil({this.timezone, this.offset, this.timestamp});

  ActiveUntil.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class Personal {
  String userName;
  String image;
  String story;
  int serviceID;
  String serviceTitle;
  String description;
  int categoryID;
  ActiveUntil activeUntil;
  List<String> tags;

  Personal(
      {this.userName,
      this.image,
      this.story,
      this.serviceID,
      this.serviceTitle,
      this.description,
      this.categoryID,
      this.activeUntil,
      this.tags});

  Personal.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    image = json['image'];
    story = json['story'];
    serviceID = json['serviceID'];
    serviceTitle = json['serviceTitle'];
    description = json['description'];
    categoryID = json['categoryID'];
    activeUntil = json['activeUntil'] != null
        ? new ActiveUntil.fromJson(json['activeUntil'])
        : null;
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['story'] = this.story;
    data['serviceID'] = this.serviceID;
    data['serviceTitle'] = this.serviceTitle;
    data['description'] = this.description;
    data['categoryID'] = this.categoryID;
    if (this.activeUntil != null) {
      data['activeUntil'] = this.activeUntil.toJson();
    }
    data['tags'] = this.tags;
    return data;
  }
}
