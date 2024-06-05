import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/usecases/usecase.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class PostUser extends UseCase<String, PostUserParams> {
  final UserRepository userRepository;

  PostUser(this.userRepository);
  @override
  Future<Either<Failure, String>> call(PostUserParams params) =>
      userRepository.addUser(params);
}
