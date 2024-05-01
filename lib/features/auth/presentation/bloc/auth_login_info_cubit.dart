import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/core/usecases/no_params.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/features/auth/data/models/user_info_model.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/delete_access_token.dart';
import 'package:skk_iden_mobile/features/auth/domain/usecases/get_user_login_info.dart';

class AuthLoginInfoCubit extends Cubit<DataState> {
  GetUserLoginInfo getUserLoginInfo;
  DeleteAccessToken deleteAccessToken;

  AuthLoginInfoCubit(this.getUserLoginInfo, this.deleteAccessToken)
      : super(DataState.initial());

  void getLoginInfo() async {
    emit(DataState.inProgress());

    final result = await getUserLoginInfo(NoParams());

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) {
        final user = UserInfoModel.fromJson(r.data);
        CredentialSaver.userInfoModel = user;
        emit(DataState.success(data: user));
      },
    );
  }

  void removeAccessToken() async {
    emit(DataState.inProgress());

    await deleteAccessToken(NoParams());
  }
}
