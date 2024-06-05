import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class DeleteUser extends UseCase<String, String> {
  final UserRepository userRepository;

  DeleteUser(this.userRepository);
  @override
  Future<Either<Failure, String>> call(String params) =>
      userRepository.deleteUser(params);
}
