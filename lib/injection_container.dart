import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skk_iden_mobile/core/network_info.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_preference_helper.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:skk_iden_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:skk_iden_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/delete_access_token.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/get_access_token.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/get_user_login_info.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/post_login.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_login_info_cubit.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/sign_in_check_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  initNetworkCheck();
  await initExternal();
}

void initBlocs() {
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => AuthLoginInfoCubit(
        getIt(),
        getIt(),
      ));
  getIt.registerFactory(() => SignOutCubit(getIt()));
}

void initUseCases() {
  getIt.registerLazySingleton(() => PostLogin(getIt()));
  getIt.registerLazySingleton(() => GetAccessToken(getIt()));
  getIt.registerLazySingleton(() => GetUserLoginInfo(getIt()));
  getIt.registerLazySingleton(() => DeleteAccessToken(getIt()));
}

void initRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt(),
      networkInfo: getIt(),
      authPreferenceHelper: getIt(),
    ),
  );
}

void initDataSources() {
  getIt.registerLazySingleton(
    () => AuthDataSource(getIt()),
  );

  getIt.registerLazySingleton<AuthPreferenceHelper>(
    () => AuthPreferenceHelperImpl(getIt()),
  );
}

void initNetworkCheck() {
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
}

Future<void> initExternal() async {
  final preference = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => preference);

  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton(() => InternetConnectionChecker());
}