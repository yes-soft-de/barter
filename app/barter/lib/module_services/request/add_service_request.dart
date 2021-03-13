class AddServiceRequest {
  String serviceTitle;
  String description;
  String duration;
  String categoryID;
  String activeUntil;
  bool enabled;
  List<String> tags;

  AddServiceRequest({
    this.serviceTitle,
    this.description,
    this.duration,
    this.categoryID,
    this.activeUntil,
    this.enabled,
    this.tags,
  });

  AddServiceRequest.fromJson(Map<String, dynamic> json) {
    serviceTitle = json['serviceTitle'];
    description = json['description'];
    duration = json['duration'];
    categoryID = json['categoryID'];
    activeUntil = json['activeUntil'];
    enabled = json['enabled'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceTitle'] = this.serviceTitle;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['categoryID'] = this.categoryID;
    data['activeUntil'] = this.activeUntil;
    data['enabled'] = this.enabled;
    data['tags'] = this.tags;
    return data;
  }
}
