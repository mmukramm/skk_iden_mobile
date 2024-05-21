import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/core/utils/const.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';

class KeywordsRepositoryImpl implements KeywordsRepository {
  final KeywordsDataSource keywordsDataSource;
  KeywordsRepositoryImpl({required this.keywordsDataSource});

  @override
  Future<Either<Failure, Keyword>> getKeywordsPagination(
    GetAllKeywordParams getAllKeywordParams,
  ) async {
    try {
      final result = await keywordsDataSource.getKeywords(
        'Bearer ${CredentialSaver.accessToken}',
        getAllKeywordParams.key,
        getAllKeywordParams.page,
      );

      final keyword = Keyword.fromMap(result.data);

      return Right(keyword);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(authFailureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }

      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> postKeyword(
    PostKeywordParams postKeywordParams,
  ) async {
    try {
      final result = await keywordsDataSource.addKeyword(
        'Bearer ${CredentialSaver.accessToken}',
        postKeywordParams.toJson(),
      );

      return Right(result.data as String);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(authFailureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }

      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> deleteKeyword(
    String id,
  ) async {
    try {
      final result = await keywordsDataSource.deleteKeyword(
        'Bearer ${CredentialSaver.accessToken}',
        id,
      );

      return Right(result.data as String);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(authFailureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }

      return Left(ServerFailure(e.message!));
    }
  }
}
