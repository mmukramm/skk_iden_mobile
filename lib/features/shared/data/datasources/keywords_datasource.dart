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
  Future<ApiResponse> getKeywords(
    @Header('Authorization') String accessToken,
    @Query('key') String key,
    @Query('page') int page,
  );

  @POST('/api/keywords')
  Future<ApiResponse> addKeyword(
    @Header('Authorization') String accessToken,
    @Body() Map<String, String> param,
  );

  @DELETE('/api/keywords/{id}')
  Future<ApiResponse> deleteKeyword(
    @Header('Authorization') String accessToken,
    @Path('id') String param,
  );
}

class PostKeywordParams {
  final String keyword;
  final String definition;

  PostKeywordParams({
    required this.keyword,
    required this.definition,
  });

  Map<String, String> toJson() => {
        "keyword": keyword,
        "definition": definition,
      };
}

class GetAllKeywordParams {
  final int page;
  final String key;

  GetAllKeywordParams({
    required this.page,
    required this.key,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "key": key,
      };
}
