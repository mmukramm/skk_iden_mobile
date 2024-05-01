// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'package:skk_iden_mobile/core/api_response.dart';
import 'package:skk_iden_mobile/core/const.dart';

part 'auth_datasource.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  @POST('/api/users/login')
  Future<ApiResponse> signIn(@Body() Map<String, String> param);
  
  @GET('/api/users/info')
  Future<ApiResponse> signInCheck(@Header('Authorization') String accessToken);
}

class SignInParams {
  String username;
  String password;

  SignInParams({
    required this.username,
    required this.password,
  });

  Map<String, String> toJson() => {
        "username": username,
        "password": password,
      };
}
