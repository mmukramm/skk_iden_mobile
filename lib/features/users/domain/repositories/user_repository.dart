import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';
import 'package:skk_iden_mobile/features/users/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getAllUsers();
  Future<Either<Failure, String>> deleteUser(String id);
  Future<Either<Failure, String>> editUser(PostUserParams params);
  Future<Either<Failure, String>> addUser(PostUserParams params);
}