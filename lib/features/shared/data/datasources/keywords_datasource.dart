
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';

import 'package:skk_iden_mobile/core/utils/const.dart';

part 'keywords_datasource.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class KeywordsDataSource {
  factory KeywordsDataSource(Dio dio, {String baseUrl}) = _KeywordsDataSource;

  @GET('/api/keywords')
  Future<ApiResponse> getKeywords(@Header('Authorization') String accessToken, @Query('page') int page);
}