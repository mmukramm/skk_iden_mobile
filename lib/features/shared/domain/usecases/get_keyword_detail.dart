import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_detail.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';

class GetKeywordDetail extends UseCase<KeywordDetail, String> {
  final KeywordsRepository keywordsRepository;

  GetKeywordDetail(this.keywordsRepository);

  @override
  Future<Either<Failure, KeywordDetail>> call(String params) =>
      keywordsRepository.getKeywordDetail(params);
}
