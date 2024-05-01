import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/no_params.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';

class GetAccessToken extends UseCase<String, NoParams> {
  final AuthRepository authRepository;

  GetAccessToken(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      authRepository.getAccessToken();
}
