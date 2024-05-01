import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_login_info_cubit.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/sign_in_check_cubit.dart';
import 'package:skk_iden_mobile/wrapper.dart';

import 'package:skk_iden_mobile/injection_container.dart' as di;
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/core/theme/theme.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:skk_iden_mobile/injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
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
