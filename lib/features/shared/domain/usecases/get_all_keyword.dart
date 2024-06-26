import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';

class GetAllKeyword extends UseCase<Keyword, GetAllKeywordParams> {
  final KeywordsRepository keywordsRepository;

  GetAllKeyword(this.keywordsRepository);

  @override
  Future<Either<Failure, Keyword>> call(GetAllKeywordParams params) =>
      keywordsRepository.getKeywordsPagination(params);
}
