import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/no_params.dart';
import 'package:skk_iden_mobile/core/usecase.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccessToken extends UseCase<bool, NoParams> {
  AuthRepository authRepository;

  DeleteAccessToken(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      authRepository.deleteAccessToken();
}
