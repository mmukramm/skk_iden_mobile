import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';

abstract class KeywordsRepository {
  Future<Either<Failure, Keyword>> getKeywordsPagination(int page);
}