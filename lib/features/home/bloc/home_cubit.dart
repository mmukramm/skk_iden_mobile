import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/features/home/bloc/state/home_state.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/domain/usecases/get_all_keyword.dart';

class HomeCubit extends Cubit<HomeState> {
  GetAllKeyword getAllKeyword;
  HomeCubit(this.getAllKeyword) : super(HomeState.initial());

  void getKeywords({
    required int page,
    String key = "",
  }) async {
    emit(HomeState.inProgress());

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
}
