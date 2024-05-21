import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/home/bloc/home_cubit.dart';
import 'package:skk_iden_mobile/features/home/bloc/state/home_state.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_data.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_search_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_text_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<KeywordData> keywords;
  late final HomeCubit homeCubit;
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
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.isInitial || key.isEmpty) {
                  return const SizedBox();
                }

                if (state.isInProgress) {
                  return const Loading(color: primaryColor);
                }

                if (state.isEmpty) {
                  return const Text("No Data Found");
                }

                if (state.isSuccess) {
                  final fetchedKeywords = state.data! as Keyword;

                  totalPage = fetchedKeywords.pagination!.totalPage;
                  previousPage = fetchedKeywords.pagination!.prevPage;
                  nextPage = fetchedKeywords.pagination!.nextPage;

                  keywords.addAll(fetchedKeywords.keywordData!);
                }

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryBackgroundColor,
                  ),
                  child: Column(
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
                          return KeywordItem(
                            keyword: keywords[index].keyword ?? "",
                            onTap: () {
                              debugPrint("awooo ${keywords[index]}");
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
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
