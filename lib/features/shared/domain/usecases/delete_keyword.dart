import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';

class DeleteKeyword extends UseCase<String, String> {
  KeywordsRepository keywordsRepository;

  DeleteKeyword(this.keywordsRepository);

  @override
  Future<Either<Failure, String>> call(String params) =>
      keywordsRepository.deleteKeyword(params);
}
