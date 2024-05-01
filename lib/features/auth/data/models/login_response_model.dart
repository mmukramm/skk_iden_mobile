class LoginResponseModel {
  final String? token;

  LoginResponseModel({this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
      );
}
