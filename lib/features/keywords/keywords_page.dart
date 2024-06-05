import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skk_iden_mobile/core/enums/snack_bar_type.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/date_formatter.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_cubit.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/state/keywords_state.dart';
import 'package:skk_iden_mobile/features/keywords/keywords_detail_page.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_data.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_search_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/features/shared/widget/no_data_found.dart';

class KeywordsPage extends StatefulWidget {
  const KeywordsPage({super.key});

  @override
  State<KeywordsPage> createState() => _KeywordsPageState();
}

class _KeywordsPageState extends State<KeywordsPage> {
  late final ScrollController scrollController;
  late final List<KeywordData> keywords;
  late final ValueNotifier<bool> fabOpacity;
  late final ValueNotifier<bool> showLoadMoreLoading;
  late final KeywordsCubit keywordsCubit;
  late String key;
  late int currentPage;
  int? totalPage;
  int? previousPage;
  int? nextPage;

  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    keywords = [];
    currentPage = 1;
    scrollController = ScrollController();
    fabOpacity = ValueNotifier(false);
    showLoadMoreLoading = ValueNotifier(false);
    key = "";
    keywordsCubit = context.read<KeywordsCubit>();

    keywordsCubit.getKeywords(
      page: currentPage,
      key: key,
    );

    scrollController.addListener(() {
      fabOpacity.value = scrollController.offset > 10;

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        showLoadMoreLoading.value = true;
        if (totalPage != currentPage) {
          currentPage++;
          keywordsCubit.getMoreKeywords(
            page: currentPage,
            key: key,
          );
        } else {
          showLoadMoreLoading.value = false;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
        valueListenable: fabOpacity,
        builder: (_, value, child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: value ? 1 : 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: secondaryBackgroundColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Back to Top",
                        style: textTheme.titleMedium!.copyWith(
                          color: scaffoldColor,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(
                        AssetPath.getIcon("arrow-up-circle.svg"),
                      ),
                    ],
                  ),
                  onPressed: () => scrollToTop(),
                ),
              ],
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Text(
                "Daftar Kata Kunci",
                style: textTheme.titleLarge!.copyWith(
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.showAddKeywordDialog(
                      title: "Tambah Kata Kunci",
                      formKey: formKey,
                      onTapPrimaryButton: () => addKeyword(),
                    );
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetPath.getIcon("plus.svg")),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Tambah Kata Kunci",
                        style: textTheme.titleSmall!.copyWith(
                          color: scaffoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomSearchField(
                name: "keyword",
                hintText: "Cari kata kunci...",
                onChange: (value) {
                  currentPage = 1;
                  keywords.clear();
                  key = value!;
                  keywordsCubit.getKeywords(
                    page: currentPage,
                    key: value,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              BlocConsumer<KeywordsCubit, KeywordsState<Keyword>>(
                listener: (_, state) {
                  if (state.isFailure) {
                    currentPage--;
                    context.showSnackBar(
                      message: state.message!,
                      type: SnackBarType.error,
                    );
                  }
                  if (state.isMutateDataSuccess) {
                    context.showSnackBar(
                      message: state.message!,
                      type: SnackBarType.success,
                    );
                    currentPage = 1;
                    keywords.clear();
                    keywordsCubit.getKeywords(
                      page: currentPage,
                      key: key,
                    );
                  }
                },
                builder: (_, state) {
                  if (state.isInProgress) {
                    return const Loading(
                      color: primaryColor,
                    );
                  }

                  if (state.isEmpty) {
                    return const Center(
                      child: NoDataFound(
                        message: "Data tidak ditemukan",
                      ),
                    );
                  }

                  if (state.isSuccess) {
                    final fetchedKeywords = state.data!;

                    totalPage = fetchedKeywords.pagination!.totalPage;
                    previousPage = fetchedKeywords.pagination!.prevPage;
                    nextPage = fetchedKeywords.pagination!.nextPage;

                    keywords.addAll(fetchedKeywords.keywordData!);
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: keywords.length,
                    itemBuilder: (_, index) {
                      final keyword = keywords[index];
                      return KeywordItem(
                        item: keyword,
                        onTapDeleteButton: () => deleteKeyword(keyword),
                      );
                    },
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: showLoadMoreLoading,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value,
                    child: const Loading(
                      color: primaryColor,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteKeyword(KeywordData keyword) {
    keywordsCubit.removeKeyword(
      id: keyword.keywordId!,
    );
    navigatorKey.currentState!.pop();
  }

  void addKeyword() {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;
      keywordsCubit.addKeyword(
        postKeywordParams: PostKeywordParams(
          keyword: value['keyword'],
          definition: value['definition'],
        ),
      );
      navigatorKey.currentState!.pop();
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}

class KeywordItem extends StatelessWidget {
  const KeywordItem(
      {super.key, required this.item, required this.onTapDeleteButton});

  final KeywordData item;
  final VoidCallback onTapDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.keyword ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleLarge!.copyWith(color: primaryColor),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            item.definition ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(color: primaryColor),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset(
                width: 32,
                height: 32,
                AssetPath.getIcon("user.svg"),
                colorFilter: const ColorFilter.mode(
                  primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(item.user ?? ""),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SvgPicture.asset(
                width: 32,
                height: 32,
                AssetPath.getIcon("calendar.svg"),
                colorFilter: const ColorFilter.mode(
                  primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(formatDateTime(item.createdAt ?? "")),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.showConfirmationDialog(
                      title: "Hapus Kata Kunci",
                      message:
                          "Apakah Anda yakin ingin menghapus kata kunci ini?",
                      onTapPrimaryButton: onTapDeleteButton,
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: dangerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AssetPath.getIcon("trash.svg"),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => KeywordsDetailPage(
                          id: item.keywordId!,
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: infoColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AssetPath.getIcon("eye_open.svg"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
