import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_all_keyword.dart';

class KeywordsCubit extends Cubit<DataState<Keyword>> {
  GetAllKeyword getAllKeyword;

  KeywordsCubit(this.getAllKeyword) : super(DataState.initial());

  void getKeywords(int page) async {
    emit(DataState.inProgress());

    final result = await getAllKeyword(page);

    result.fold(
      (l) => emit(DataState.failure(l.message)),
      (r) => emit(DataState.success(data: r)),
    );
  }
}
