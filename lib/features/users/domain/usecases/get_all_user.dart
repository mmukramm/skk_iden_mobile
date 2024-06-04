import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/no_params.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class GetAllUser extends UseCase<ApiResponse, NoParams> {
  final UserRepository userRepository;

  GetAllUser(this.userRepository);

  @override
  Future<Either<Failure, ApiResponse>> call(NoParams params) =>
      userRepository.getAllUsers();
}
