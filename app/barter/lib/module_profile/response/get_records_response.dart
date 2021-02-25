class GetRecordsResponse {
  String statusCode;
  String msg;

  GetRecordsResponse({this.statusCode, this.msg});

  GetRecordsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    return data;
  }
}
