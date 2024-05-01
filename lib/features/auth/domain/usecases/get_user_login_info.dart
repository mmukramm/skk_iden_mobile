import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/api_response.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/no_params.dart';
import 'package:skk_iden_mobile/core/usecase.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';

class GetUserLoginInfo extends UseCase<ApiResponse, NoParams> {
  final AuthRepository authRepository;
  
  GetUserLoginInfo(this.authRepository);

  @override
  Future<Either<Failure, ApiResponse>> call(NoParams params) =>
      authRepository.getUserLoginInfo();
}
