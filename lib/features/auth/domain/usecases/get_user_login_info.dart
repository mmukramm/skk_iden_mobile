import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/no_params.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';

class GetUserLoginInfo extends UseCase<ApiResponse, NoParams> {
  final AuthRepository authRepository;
  
  GetUserLoginInfo(this.authRepository);

  @override
  Future<Either<Failure, ApiResponse>> call(NoParams params) =>
      authRepository.getUserLoginInfo();
}
