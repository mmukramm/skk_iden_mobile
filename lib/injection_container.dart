import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:skk_iden_mobile/features/home/bloc/home_cubit.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_cubit.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_detail_cubit.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/repositories/keywords_repository_impl.dart';
import 'package:skk_iden_mobile/features/shared/domain/repositories/keywords_repository.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/delete_keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/delete_keyword_definition.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_all_keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_keyword_detail.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/post_keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/post_keyword_definition.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';
import 'package:skk_iden_mobile/features/users/data/repositories/user_repository_impl.dart';
import 'package:skk_iden_mobile/features/users/domain/repositories/user_repository.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/delete_user.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/get_all_user.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/post_user.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/put_user.dart';
import 'package:skk_iden_mobile/features/users/presentation/bloc/users_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  await initExternal();
}

void initBlocs() {
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => AuthLoginInfoCubit(
        getIt(),
        getIt(),
      ));
  getIt.registerFactory(() => SignOutCubit(getIt()));
  getIt.registerFactory(() => KeywordsCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
  getIt.registerFactory(() => KeywordsDetailCubit(
        getIt(),
        getIt(),
        getIt(),
      ));
  getIt.registerFactory(() => HomeCubit(
        getIt(),
        getIt(),
      ));
  getIt.registerFactory(() => UsersCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
}

void initUseCases() {
  getIt.registerLazySingleton(() => PostLogin(getIt()));
  getIt.registerLazySingleton(() => GetAccessToken(getIt()));
  getIt.registerLazySingleton(() => GetUserLoginInfo(getIt()));
  getIt.registerLazySingleton(() => DeleteAccessToken(getIt()));

  getIt.registerLazySingleton(() => GetAllKeyword(getIt()));
  getIt.registerLazySingleton(() => PostKeyword(getIt()));
  getIt.registerLazySingleton(() => DeleteKeyword(getIt()));
  getIt.registerLazySingleton(() => GetKeywordDetail(getIt()));
  getIt.registerLazySingleton(() => PostKeywordDefinition(getIt()));
  getIt.registerLazySingleton(() => DeleteKeywordDefinition(getIt()));

  getIt.registerLazySingleton(() => GetAllUser(getIt()));
  getIt.registerLazySingleton(() => DeleteUser(getIt()));
  getIt.registerLazySingleton(() => PutUser(getIt()));
  getIt.registerLazySingleton(() => PostUser(getIt()));
}

void initRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt(),
      authPreferenceHelper: getIt(),
    ),
  );

  getIt.registerLazySingleton<KeywordsRepository>(
    () => KeywordsRepositoryImpl(keywordsDataSource: getIt()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userDataSource: getIt()),
  );
}

void initDataSources() {
  getIt.registerLazySingleton(
    () => AuthDataSource(getIt()),
  );

  getIt.registerLazySingleton<AuthPreferenceHelper>(
    () => AuthPreferenceHelperImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => KeywordsDataSource(getIt()),
  );

  getIt.registerLazySingleton(
    () => UserDataSource(getIt()),
  );
}

Future<void> initExternal() async {
  final preference = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => preference);

  getIt.registerLazySingleton(() => Dio());
}
