class SignInResponseModel {
  String? token;
  String? type;

  SignInResponseModel({this.token, this.type});

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    return data;
  }
}
