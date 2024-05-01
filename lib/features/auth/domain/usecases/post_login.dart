import 'package:dartz/dartz.dart';

import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecase.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';

class PostLogin implements UseCase<bool, SignInParams> {
  final AuthRepository authRepository;

  PostLogin(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(SignInParams signInParams) =>
      authRepository.signIn(signInParams);
}
