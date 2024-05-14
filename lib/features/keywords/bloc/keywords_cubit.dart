import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/state/keywords_state.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_all_keyword.dart';

class KeywordsCubit extends Cubit<KeywordsState<Keyword>> {
  GetAllKeyword getAllKeyword;

  KeywordsCubit(this.getAllKeyword) : super(KeywordsState.initial());

  void getKeywords(int page) async {
    emit(KeywordsState.inProgress());

    final result = await getAllKeyword(page);

    result.fold(
      (l) => emit(KeywordsState.failure(l.message)),
      (r) => emit(KeywordsState.success(data: r)),
    );
  }

  void getMoreKeywords(int page) async {
    emit(KeywordsState.onLoadmore());

    final result = await getAllKeyword(page);

    result.fold(
      (l) => emit(KeywordsState.failure(l.message)),
      (r) => emit(KeywordsState.success(data: r)),
    );
  }

  // void getMoreKeywords(int page) async {
  //   emit(DataState.inProgress());

  //   final result = await getAllKeyword(page);

  //   result.fold(
  //     (l) => emit(DataState.failure(l.message)),
  //     (r) => emit(DataState.success(data: r)),
  //   );
  // }
}
