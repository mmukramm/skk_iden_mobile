import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/no_params.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/users/data/models/user_model.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class GetAllUser extends UseCase<List<UserModel>, NoParams> {
  final UserRepository userRepository;

  GetAllUser(this.userRepository);

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) =>
      userRepository.getAllUsers();
}
