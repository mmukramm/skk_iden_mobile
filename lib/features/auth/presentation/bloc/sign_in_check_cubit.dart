import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/no_params.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/delete_access_token.dart';

class SignOutCubit extends Cubit<DataState<bool>> {
  DeleteAccessToken deleteAccessToken;
  SignOutCubit(this.deleteAccessToken) : super(DataState.initial());

  void signOut() async {
    emit(DataState.inProgress());

    final result = await deleteAccessToken(NoParams());

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) => emit(DataState.success(data: r)),
    );
  }
}
