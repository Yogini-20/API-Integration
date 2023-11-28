class LoginResponse {
  String? id;
  String? emailId;
  String? orgname;
  String? name;
  String? phoneNumber;
  int? status;
  String? message;

  LoginResponse(
      {this.id,
        this.emailId,
        this.orgname,
        this.name,
        this.phoneNumber,
        this.status,
        this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emailId = json['emailId'];
    orgname = json['orgname'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emailId'] = this.emailId;
    data['orgname'] = this.orgname;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
