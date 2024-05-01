import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/credential_saver.dart';
import 'package:skk_iden_mobile/core/keys.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_login_info_cubit.dart';
import 'package:skk_iden_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/features/skk_iden.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authLoginInfoCubit = context.read<AuthLoginInfoCubit>();
    authLoginInfoCubit.getLoginInfo();
    return BlocListener<AuthLoginInfoCubit, DataState>(
      listener: (_, state) {
        if (state.isSuccess) {
          CredentialSaver.userInfoModel = state.data;
          debugPrint(state.data.toString());
          navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => const SkkIden()),
          );
        }

        if (state.isFailure) {
          CredentialSaver.accessToken = null;
          CredentialSaver.userInfoModel = null;
          authLoginInfoCubit.removeAccessToken();
          navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: const Scaffold(
        body: Loading(
          color: primaryColor,
        ),
      ),
    );
  }
}
