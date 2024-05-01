import 'package:dartz/dartz.dart';
import 'package:skk_iden_mobile/core/api_response.dart';

import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signIn(SignInParams signInParams);
  Future<Either<Failure, String>> getAccessToken();
  Future<Either<Failure, bool>> deleteAccessToken();
  
  Future<Either<Failure, ApiResponse>> getUserLoginInfo();
}