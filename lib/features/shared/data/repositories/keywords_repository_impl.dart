import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  Future<Either<Failure, Keyword>> getKeywordsPagination(int page) async {
    try {
      final result = await keywordsDataSource.getKeywords(
          'Bearer ${CredentialSaver.accessToken}', page);

      debugPrint(result.data.toString());

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
}
