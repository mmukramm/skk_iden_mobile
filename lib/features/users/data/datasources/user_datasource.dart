import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/core/utils/const.dart';

part 'user_datasource.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  @GET('/api/users')
  Future<ApiResponse> getAllUsers(@Header('Authorization') String accessToken);

  @DELETE('/api/users/{id}')
  Future<ApiResponse> deleteUser(
    @Header('Authorization') String accessToken,
    @Path('id') String id,
  );

  @PUT('/api/users/{id}')
  Future<ApiResponse> editUser(
    @Header('Authorization') String accessToken,
    @Path('id') String id,
    @Body() Map<String, dynamic> params,
  );

  @POST('/api/users')
  Future<ApiResponse> addUser(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> params,
  );

}

class PostUserParams {
  final String? id;
  final String name;
  final String username;
  final String? password;
  final bool isAdmin;
  PostUserParams({
    this.id,
    required this.name,
    required this.username,
    required this.isAdmin,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'password': password,
      'is_admin': isAdmin,
    }..removeWhere((key, value) => value == null);
  }
}
