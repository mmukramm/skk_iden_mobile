import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skk_iden_mobile/core/errors/failure.dart';
import 'package:skk_iden_mobile/core/utils/api_response.dart';
import 'package:skk_iden_mobile/core/utils/const.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';
import 'package:skk_iden_mobile/features/users/data/models/user_model.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final result = await userDataSource
          .getAllUsers('Bearer ${CredentialSaver.accessToken}');

      final users = List<UserModel>.from(
        (result.data as List<dynamic>).map<UserModel>(
          (e) => UserModel.fromMap(e as Map<String, dynamic>),
        ),
      );

      return Right(users);
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
  Future<Either<Failure, String>> deleteUser(String id) async {
    try {
      final result = await userDataSource.deleteUser(
        'Bearer ${CredentialSaver.accessToken}',
        id,
      );

      return Right(result.data as String);
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
  Future<Either<Failure, String>> addUser(PostUserParams params) async {
    try {
      final result = await userDataSource.addUser(
        'Bearer ${CredentialSaver.accessToken}',
        params.toMap(),
      );

      return Right(result.data as String);
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
  Future<Either<Failure, String>> editUser(
    PostUserParams postUserParams,
  ) async {
    try {
      final result = await userDataSource.editUser(
        'Bearer ${CredentialSaver.accessToken}',
        postUserParams.id!,
        postUserParams.toMap(),
      );

      return Right(result.data as String);
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
