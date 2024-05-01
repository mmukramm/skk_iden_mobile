import 'package:skk_iden_mobile/core/utils/const.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ConnectionFailure extends Failure{
  const ConnectionFailure(super.message);
}

class CacheFailure extends Failure{
  const CacheFailure(super.message);
}

class ServerFailure extends Failure{
  const ServerFailure(super.message);
}

Failure authFailureMessageHandler(String errorMessage) {
  switch (errorMessage) {
    case kUserNotFound:
      return const ServerFailure("User Tidak Ditemukan");
    case kUsernameOrPasswordIncorrect:
      return const ServerFailure("Username atau Password salah");
    default:
      return ServerFailure(errorMessage);
  }
}