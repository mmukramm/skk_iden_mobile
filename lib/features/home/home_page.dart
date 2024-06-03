import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/date_formatter.dart';
import 'package:skk_iden_mobile/features/home/bloc/home_cubit.dart';
import 'package:skk_iden_mobile/features/home/bloc/state/home_state.dart';
import 'package:skk_iden_mobile/features/shared/data/models/definition_detail.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_data.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_search_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/features/shared/widget/no_data_found.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<KeywordData> keywords;
  late final HomeCubit homeCubit;
  late ValueNotifier<bool> isRetryVisible;
  late ValueNotifier<bool> showLoadMoreLoading;
  late String key;
  late int currentPage;
  int? totalPage;
  int? previousPage;
  int? nextPage;

  @override
  void initState() {
    super.initState();

    keywords = List.empty(growable: true);
    key = '';
    showLoadMoreLoading = ValueNotifier(false);
    isRetryVisible = ValueNotifier(false);
    currentPage = 1;
    homeCubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          RichText(
            selectionColor: primaryColor,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: "Surat Kabar Kampus (SKK)\n",
                ),
                TextSpan(
                  text: "Identitas Unhas",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomSearchField(
              name: "keyword",
              labelText: "Cari Kata Kunci",
              labelTextAlign: TextAlign.center,
              hintText: "Masukkan kata kunci...",
              onChange: (value) {
                currentPage = 1;
                keywords.clear();
                key = value!;
                homeCubit.getKeywords(
                  page: currentPage,
                  key: key,
                );
              },
              onClickClearIcon: () {
                nextPage = null;
                previousPage = null;
              },
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  final fetchedKeywords = state.data! as Keyword;

                  totalPage = fetchedKeywords.pagination!.totalPage;
                  previousPage = fetchedKeywords.pagination!.prevPage;
                  nextPage = fetchedKeywords.pagination!.nextPage;

                  showLoadMoreLoading.value = false;
                }

                isRetryVisible.value = nextPage != null && state.isSuccess;

                if (state.isInitial || key.isEmpty) {
                  isRetryVisible.value = false;
                }
              },
              builder: (context, state) {
                if (state.isInitial || key.isEmpty) {
                  return const SizedBox();
                }

                if (state.isInProgress) {
                  return const Loading(color: primaryColor);
                }

                if (state.isEmpty) {
                  return const NoDataFound(
                    message: "Data tidak ditemukan",
                  );
                }

                if (state.isSuccess) {
                  final fetchedKeywords = state.data! as Keyword;

                  keywords.addAll(fetchedKeywords.keywordData!);
                }

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryBackgroundColor,
                  ),
                  child: state.isDetail
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                keywords.clear();
                                currentPage = 1;
                                nextPage = null;
                                previousPage = null;
                                homeCubit.getKeywords(
                                  page: currentPage,
                                  key: key,
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.data.keyword,
                                    style: textTheme.titleLarge!.copyWith(
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Dibuat pada: ${formatDateTime(state.data.definition[0].createdAt)}",
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    state.data.definition[0].definition.trim(),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Riwayat',
                                    style: textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final data = state.data.definition
                                          as List<DefinitionDetail>;
                                      debugPrint(data[0].definition);
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            formatDateTime(
                                              data[index].createdAt!,
                                            ),
                                            style: textTheme.titleSmall,
                                          ),
                                          Text(data[index].definition!.trim()),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (_, __) => const SizedBox(
                                      height: 12,
                                    ),
                                    itemCount: state.data.definition.length,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hasil Pencarian",
                              style: textTheme.titleMedium!.copyWith(
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: keywords.length,
                              itemBuilder: (_, index) {
                                final keywordData = keywords[index];
                                return KeywordItem(
                                  keyword: keywordData.keyword ?? "",
                                  onTap: () {
                                    debugPrint("awooo $keywordData");
                                    homeCubit.getOneKeywordDetail(
                                      id: keywordData.keywordId!,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                );
              },
            ),
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
          ValueListenableBuilder(
            valueListenable: isRetryVisible,
            builder: (_, value, __) {
              return Visibility(
                visible: value,
                child: Column(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        AssetPath.getIcon("retry.svg"),
                        colorFilter: const ColorFilter.mode(
                          primaryBackgroundColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      style:
                          IconButton.styleFrom(backgroundColor: primaryColor),
                      onPressed: () {
                        showLoadMoreLoading.value = true;
                        currentPage++;
                        homeCubit.getMoreKeywords(
                          page: currentPage,
                          key: key,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Load More"),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class KeywordItem extends StatelessWidget {
  const KeywordItem({
    super.key,
    required this.keyword,
    required this.onTap,
  });

  final String keyword;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: secondaryColor,
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              keyword,
              style: textTheme.bodyMedium!.copyWith(
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
