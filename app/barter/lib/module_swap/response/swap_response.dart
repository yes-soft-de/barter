class SwapListResponse {
  String statusCode;
  String msg;
  List<Data> data;

  SwapListResponse({this.statusCode, this.msg, this.data});

  SwapListResponse.fromJson(Map<String, dynamic> json) {
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
  String userIdOne;
  String userIdTwo;
  List<SwapItems> swapItemsOne;
  List<SwapItems> swapItemsTwo;
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
      swapItemsOne = <SwapItems>[];
      json['swapItemsOne'].forEach((v) {
        swapItemsOne.add(new SwapItems.fromJson(v));
      });
    }
    if (json['swapItemsTwo'] != null) {
      swapItemsTwo = <SwapItems>[];
      json['swapItemsTwo'].forEach((v) {
        swapItemsTwo.add(new SwapItems.fromJson(v));
      });
    }
    id = json['id'];
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
      data['swapItemsOne'] = this.swapItemsOne.map((v) => v.toJson()).toList();
    }
    if (this.swapItemsTwo != null) {
      data['swapItemsTwo'] = this.swapItemsTwo.map((v) => v.toJson()).toList();
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

class SwapItems {
  String id;
  String serviceTitle;

  SwapItems({this.id, this.serviceTitle});

  SwapItems.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    serviceTitle = json['serviceTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceTitle'] = this.serviceTitle;
    return data;
  }
}

class Date {
  Timezone timezone;
  int offset;
  int timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
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
