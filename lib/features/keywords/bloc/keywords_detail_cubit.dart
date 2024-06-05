import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/state/keywords_detail_state.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_detail.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/delete_keyword_definition.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_keyword_detail.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/post_keyword_definition.dart';

class KeywordsDetailCubit extends Cubit<KeywordsDetailState<KeywordDetail>> {
  GetKeywordDetail getKeywordDetail;
  PostKeywordDefinition postKeywordDefinition;
  DeleteKeywordDefinition deleteKeywordDefinition;

  KeywordsDetailCubit(
    this.getKeywordDetail,
    this.postKeywordDefinition,
    this.deleteKeywordDefinition,
  ) : super(KeywordsDetailState.initial());

  void getOneKeywordDetail({
    required String id,
  }) async {
    emit(KeywordsDetailState.inProgress());

    final result = await getKeywordDetail(id);

    result.fold(
      (l) => emit(KeywordsDetailState.failure(l.message)),
      (r) => emit(KeywordsDetailState.success(data: r)),
    );
  }

  void addKeywordDefinition({
    required UpdateKeywordDefinitionParams params,
  }) async {
    emit(KeywordsDetailState.inProgress());

    final result = await postKeywordDefinition(params);

    result.fold(
      (l) => emit(KeywordsDetailState.failure(l.message)),
      (r) => emit(KeywordsDetailState.mutateDataSuccess(message: r)),
    );
  }

  void deleteOneKeywordDefinition({
    required String id,
  }) async {
    emit(KeywordsDetailState.inProgress());

    final result = await deleteKeywordDefinition(id);

    result.fold(
      (l) => emit(KeywordsDetailState.failure(l.message)),
      (r) => emit(KeywordsDetailState.mutateDataSuccess(message: r)),
    );
  }
}
