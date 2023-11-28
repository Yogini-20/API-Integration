class LoginResponse {
  String? orgname;
  String? name;
  String? phoneNumber;
  int? status;
  String? message;

  LoginResponse(
      {this.orgname, this.name, this.phoneNumber, this.status, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    orgname = json['orgname'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['orgname'] = orgname;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
