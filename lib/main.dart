import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/core/utils/firebase_api.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_login_info_cubit.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/sign_in_check_cubit.dart';
import 'package:skk_iden_mobile/features/home/bloc/home_cubit.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_cubit.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_detail_cubit.dart';
import 'package:skk_iden_mobile/features/users/presentation/bloc/users_cubit.dart';
import 'package:skk_iden_mobile/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:skk_iden_mobile/injection_container.dart' as di;
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/core/theme/theme.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:skk_iden_mobile/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD9kAj4TV2HqfBGHBl13RMJtFu0c5WN4ZU",
      appId: "1:811256303751:android:ff3794d5b7f24a71116822",
      messagingSenderId: '811256303751',
      projectId: 'skk-iden-app',
      storageBucket: 'skkiden.appspot.com',
    ),
  );
  await FirebaseApi().init();

  await di.init();

  await CredentialSaver.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthLoginInfoCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<SignOutCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<KeywordsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<KeywordsDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<UsersCubit>(),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: navigatorKey,
        home: const Wrapper(),
      ),
    );
  }
}
