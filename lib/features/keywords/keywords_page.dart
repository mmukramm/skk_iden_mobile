import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/const.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_cubit.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_data.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_text_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/injection_container.dart';

class KeywordsPage extends StatelessWidget {
  const KeywordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<KeywordsCubit>()..getKeywords(1),
      child: BlocConsumer<KeywordsCubit, DataState<Keyword>>(
        builder: (_, state) {
          if (state.isInProgress) {
            return const Loading(
              color: primaryColor,
            );
          }

          if (state.isSuccess) {
            final keywords = state.data!.keywordData!;
            return SingleChildScrollView(
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
                        onPressed: () {},
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
                              style: textTheme.titleSmall!
                                  .copyWith(color: scaffoldColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const CustomTextField(
                      name: "keyword",
                      hintText: "Cari kata kunci...",
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: keywords.length,
                      itemBuilder: (context, index) {
                        return KeywordItem(item: keywords[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
        listener: (_, state) {
          if (state.isFailure) {
            debugPrint("Loadiiing");
            context.showSnackBar(message: state.message!);
          }
        },
      ),
    );
  }
}

class KeywordItem extends StatelessWidget {
  const KeywordItem({
    super.key,
    required this.item,
  });

  final KeywordData item;

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
              Text(item.createdAt ?? ""),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {},
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
                  onPressed: () {},
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
