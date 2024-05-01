import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:skk_iden_mobile/core/api_response.dart';
import 'package:skk_iden_mobile/core/const.dart';
import 'package:skk_iden_mobile/core/credential_saver.dart';
import 'package:skk_iden_mobile/core/errors/exception.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/network_info.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_preference_helper.dart';
import 'package:skk_iden_mobile/features/auth/data/models/login_response_model.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final AuthPreferenceHelper authPreferenceHelper;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authDataSource,
    required this.authPreferenceHelper,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> signIn(SignInParams signInParams) async {
    try {
      final result = await authDataSource.signIn(signInParams.toJson());

      final loginResponse = LoginResponseModel.fromJson(result.data);

      final isSet =
          await authPreferenceHelper.setAccessToken(loginResponse.token!);

      CredentialSaver.accessToken = loginResponse.token;

      return Right(isSet);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(authFailureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }

      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken() async {
    try {
      final accesToken = await authPreferenceHelper.getAccessToken();

      return Right(accesToken!);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> getUserLoginInfo() async {
    try {
      final result = await authDataSource
          .signInCheck('Bearer ${CredentialSaver.accessToken}');
          

      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(authFailureMessageHandler(
            ApiResponse.fromJson(e.response!.data).message!));
      }
      return Left(ServerFailure(e.message!));
    }
  }
  
  @override
  Future<Either<Failure, bool>> deleteAccessToken() async{
    try {
      final result = await authPreferenceHelper.removeAccessToken();

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message!));
    }
  }
}
