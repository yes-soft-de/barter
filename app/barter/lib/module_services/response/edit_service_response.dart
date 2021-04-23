class EditServiceResponse {
  String statusCode;
  String msg;
  Data data;

  EditServiceResponse({this.statusCode, this.msg, this.data});

  EditServiceResponse.fromJson(Map<String, dynamic> json) {
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
  String id;
  String serviceTitle;
  String description;
  Duration duration;
  String categoryID;
  Duration activeUntil;
  bool enabled;
  List<String> tags;

  Data(
      {this.id,
      this.serviceTitle,
      this.description,
      this.duration,
      this.categoryID,
      this.activeUntil,
      this.enabled,
      this.tags});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    serviceTitle = json['serviceTitle'];
    description = json['description'];
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
    categoryID = json['categoryID'].toString();
    activeUntil = json['activeUntil'] != null
        ? new Duration.fromJson(json['activeUntil'])
        : null;
    enabled = json['enabled'];
    tags = json['tags'].cast<String>();
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
    if (this.activeUntil != null) {
      data['activeUntil'] = this.activeUntil.toJson();
    }
    data['enabled'] = this.enabled;
    data['tags'] = this.tags;
    return data;
  }
}

class Duration {
  int offset;
  int timestamp;

  Duration({this.offset, this.timestamp});

  Duration.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
