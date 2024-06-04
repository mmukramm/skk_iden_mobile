import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/core/utils/const.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse>> getAllUsers() async {
    try {
      final result = await userDataSource
          .getAllUsers('Bearer ${CredentialSaver.accessToken}');

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
  Future<Either<Failure, ApiResponse>> deleteUser(String id) async {
    try {
      final result = await userDataSource.deleteUser(
        'Bearer ${CredentialSaver.accessToken}',
        id,
      );

      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(
          authFailureMessageHandler(
              ApiResponse.fromJson(e.response!.data).message!),
        );
      }
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> addUser(PostUserParams params) async {
    try {
      final result = await userDataSource.addUser(
        'Bearer ${CredentialSaver.accessToken}',
        params.toMap(),
      );

      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(
          authFailureMessageHandler(
              ApiResponse.fromJson(e.response!.data).message!),
        );
      }
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> editUser(
    PostUserParams postUserParams,
  ) async {
    try {
      final result = await userDataSource.editUser(
        'Bearer ${CredentialSaver.accessToken}',
        postUserParams.id!,
        postUserParams.toMap(),
      );

      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure(kNoInternetConnection));
      }

      if (e.response != null) {
        return Left(
          authFailureMessageHandler(
              ApiResponse.fromJson(e.response!.data).message!),
        );
      }
      return Left(ServerFailure(e.message!));
    }
  }
}
