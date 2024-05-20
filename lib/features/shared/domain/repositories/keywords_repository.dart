import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';

abstract class KeywordsRepository {
  Future<Either<Failure, Keyword>> getKeywordsPagination(GetAllKeywordParams getAllKeywordParams);
  
  Future<Either<Failure, String>> postKeyword(PostKeywordParams postKeywordParams);

  Future<Either<Failure, String>> deleteKeyword(String id);
}