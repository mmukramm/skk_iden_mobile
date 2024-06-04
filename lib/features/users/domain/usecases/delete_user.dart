import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class DeleteUser extends UseCase<ApiResponse, String> {
  final UserRepository userRepository;

  DeleteUser(this.userRepository);
  @override
  Future<Either<Failure, ApiResponse>> call(String params) =>
      userRepository.deleteUser(params);
}
