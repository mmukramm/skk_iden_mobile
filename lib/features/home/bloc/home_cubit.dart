import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/features/home/bloc/state/home_state.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_all_keyword.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_keyword_detail.dart';

class HomeCubit extends Cubit<HomeState> {
  GetAllKeyword getAllKeyword;
  GetKeywordDetail getKeywordDetail;
  HomeCubit(
    this.getAllKeyword,
    this.getKeywordDetail,
  ) : super(HomeState.initial());

  void getKeywords({
    required int page,
    String key = "",
  }) async {
    page == 1 ? emit(HomeState.inProgress()) : emit(HomeState.onLoadmore());

    final result = await getAllKeyword(
      GetAllKeywordParams(
        page: page,
        key: key,
      ),
    );

    result.fold(
      (l) => emit(HomeState.failure(l.message)),
      (r) => r.keywordData!.isNotEmpty
          ? emit(HomeState.success(data: r))
          : emit(HomeState.empty()),
    );
  }

  void getMoreKeywords({
    required int page,
    String key = "",
  }) async {
    emit(HomeState.onLoadmore());

    final result = await getAllKeyword(
      GetAllKeywordParams(page: page, key: key),
    );

    result.fold(
      (l) => emit(HomeState.failure(l.message)),
      (r) => emit(HomeState.success(data: r)),
    );
  }

  void getOneKeywordDetail({
    required String id,
  }) async {
    emit(HomeState.inProgress());

    final result = await getKeywordDetail(id);

    result.fold(
      (l) => emit(HomeState.failure(l.message)),
      (r) => emit(HomeState.detail(data: r)),
    );
  }
}
