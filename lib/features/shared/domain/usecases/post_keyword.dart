import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';

class PostKeyword extends UseCase<String, PostKeywordParams> {
  final KeywordsRepository keywordsRepository;

  PostKeyword(this.keywordsRepository);

  @override
  Future<Either<Failure, String>> call(PostKeywordParams params) =>
      keywordsRepository.postKeyword(params);
}
