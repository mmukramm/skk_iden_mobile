import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';

class GetAllKeyword extends UseCase<Keyword, int> {
  final KeywordsRepository keywordsRepository;

  GetAllKeyword(this.keywordsRepository);

  @override
  Future<Either<Failure, Keyword>> call(int params) =>
      keywordsRepository.getKeywordsPagination(params);
}
