import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/post_login.dart';

class AuthCubit extends Cubit<DataState<bool>> {
  final PostLogin postLogin;
  AuthCubit(this.postLogin) : super(DataState.initial());

  void signIn(SignInParams signInParams) async {
    emit(DataState.inProgress());

    final result = await postLogin(signInParams);

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) {
        emit(DataState.success(data: r));
      },
    );
  }
}
