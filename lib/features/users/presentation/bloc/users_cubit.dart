import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/usecases/no_params.dart';
import 'package:skk_iden_mobile/features/users/data/datasources/user_datasource.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/delete_user.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/get_all_user.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/post_user.dart';
import 'package:skk_iden_mobile/features/users/domain/usecases/put_user.dart';

class UsersCubit extends Cubit<DataState> {
  GetAllUser getAllUser;
  DeleteUser deleteUser;
  PutUser putUser;
  PostUser postUser;
  UsersCubit(
    this.getAllUser,
    this.deleteUser,
    this.putUser,
    this.postUser,
  ) : super(DataState.initial());

  void getListUsers() async {
    emit(DataState.inProgress());
    final result = await getAllUser(NoParams());

    result.fold(
      (l) => emit(
        DataState.failure(l.message),
      ),
      (r) => emit(
        DataState.success(data: r),
      ),
    );
  }

  void deleteOneUser({
    required String id,
  }) async {
    emit(DataState.inProgress());
    final result = await deleteUser(id);

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) => emit(DataState.mutateDataSuccess(message: r)),
    );
  }

  void addUser({
    required PostUserParams postUserParams,
  }) async {
    emit(DataState.inProgress());
    final result = await postUser(postUserParams);

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) => emit(DataState.mutateDataSuccess(message: r)),
    );
  }

  void editUser({
    required PostUserParams params,
  }) async {
    emit(DataState.inProgress());
    final result = await putUser(params);

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) => emit(DataState.mutateDataSuccess(message: r)),
    );
  }
}
