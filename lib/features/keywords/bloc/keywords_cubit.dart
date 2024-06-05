import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/state/keywords_state.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/delete_keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_all_keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_keyword_detail.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/post_keyword.dart';

class KeywordsCubit extends Cubit<KeywordsState<Keyword>> {
  GetAllKeyword getAllKeyword;
  PostKeyword postKeyword;
  DeleteKeyword deleteKeyword;
  GetKeywordDetail getKeywordDetail;

  KeywordsCubit(this.getAllKeyword, this.postKeyword, this.deleteKeyword, this.getKeywordDetail)
      : super(KeywordsState.initial());

  void getKeywords({
    required int page,
    String key = "",
  }) async {
    emit(KeywordsState.inProgress());

    final result = await getAllKeyword(
      GetAllKeywordParams(
        page: page,
        key: key,
      ),
    );

    result.fold(
      (l) => emit(KeywordsState.failure(l.message)),
      (r) => r.keywordData!.isEmpty
          ? emit(KeywordsState.empty())
          : emit(KeywordsState.success(data: r)),
    );
  }

  void getMoreKeywords({
    required int page,
    String key = "",
  }) async {
    emit(KeywordsState.onLoadmore());

    final result = await getAllKeyword(
      GetAllKeywordParams(page: page, key: key),
    );

    result.fold(
      (l) => emit(KeywordsState.failure(l.message)),
      (r) => emit(KeywordsState.success(data: r)),
    );
  }

  void addKeyword({
    required PostKeywordParams postKeywordParams,
  }) async {
    emit(KeywordsState.inProgress());

    final result = await postKeyword(postKeywordParams);

    result.fold(
      (l) => emit(KeywordsState.failure(l.message)),
      (r) => emit(KeywordsState.mutateDataSuccess(message: r)),
    );
  }

  void removeKeyword({
    required String id,
  }) async {
    emit(KeywordsState.inProgress());

    final result = await deleteKeyword(id);

    result.fold(
      (l) => emit(KeywordsState.failure(l.message)),
      (r) => emit(KeywordsState.mutateDataSuccess(message: r)),
    );
  }
  
}
