class SignUpResponse {
  int? status;
  String? message;

  SignUpResponse({this.status, this.message});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
