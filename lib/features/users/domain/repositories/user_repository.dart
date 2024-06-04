import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';

abstract class UserRepository {
  Future<Either<Failure, ApiResponse>> getAllUsers();
  Future<Either<Failure, ApiResponse>> deleteUser(String id);
  Future<Either<Failure, ApiResponse>> editUser(PostUserParams params);
  Future<Either<Failure, ApiResponse>> addUser(PostUserParams params);
}