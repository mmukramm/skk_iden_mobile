import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skk_iden_mobile/core/enums/snack_bar_type.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/date_formatter.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/keywords_detail_cubit.dart';
import 'package:skk_iden_mobile/features/keywords/bloc/state/keywords_detail_state.dart';
import 'package:skk_iden_mobile/features/shared/data/datasources/keywords_datasource.dart';
import 'package:skk_iden_mobile/features/shared/data/models/keyword_detail.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/features/shared/widget/no_data_found.dart';

class KeywordsDetailPage extends StatefulWidget {
  final String id;
  const KeywordsDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<KeywordsDetailPage> createState() => _KeywordsDetailPageState();
}

class _KeywordsDetailPageState extends State<KeywordsDetailPage> {
  late final KeywordsDetailCubit keywordsDetailCubit;
  late KeywordDetail keywordDetail;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    keywordsDetailCubit = context.read<KeywordsDetailCubit>();
    keywordsDetailCubit.getOneKeywordDetail(id: widget.id);

    keywordDetail = KeywordDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AssetPath.getImage("logo_iden.png"),
          height: 32,
        ),
        backgroundColor: primaryBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              IconButton(
                onPressed: () => navigatorKey.currentState!.pop(),
                style: IconButton.styleFrom(padding: const EdgeInsets.all(0)),
                icon: Transform.rotate(
                  angle: -math.pi / 2,
                  child: SvgPicture.asset(
                    width: 40,
                    AssetPath.getIcon('arrow-up-circle.svg'),
                    colorFilter: const ColorFilter.mode(
                      primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Detail Kata Kunci",
                style: textTheme.titleLarge!.copyWith(
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.showUpdateDefinitionDialog(
                      title: 'Edit Definisi',
                      formKey: formKey,
                      onTapPrimaryButton: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          keywordsDetailCubit.addKeywordDefinition(
                            params: UpdateKeywordDefinitionParams(
                              id: keywordDetail.keywordId!,
                              definition:
                                  formKey.currentState!.value['definition'],
                            ),
                          );
                          navigatorKey.currentState!.pop();
                        }
                      },
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetPath.getIcon("pencil.svg"),
                        colorFilter: const ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Edit Kata Kunci",
                        style: textTheme.titleSmall!.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<KeywordsDetailCubit, KeywordsDetailState>(
                listener: (context, state) {
                  if (state.isMutateDataSuccess) {
                    context.showSnackBar(
                      message: state.message!,
                      type: SnackBarType.primary,
                    );
                    keywordsDetailCubit.getOneKeywordDetail(
                      id: keywordDetail.keywordId!,
                    );
                  }
                  if (state.isFailure) {
                    context.showSnackBar(
                      message: state.message!,
                      type: SnackBarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isInProgress) {
                    return const Loading(
                      color: primaryColor,
                    );
                  }

                  if (state.isSuccess) {
                    keywordDetail = state.data as KeywordDetail;
                  }

                  if (keywordDetail.definition!.isEmpty) {
                    return NoDataFound(
                      message:
                          'Definisi untuk keyword ${keywordDetail.keyword} tidak ada. ',
                    );
                  }

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: secondaryBackgroundColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              keywordDetail.keyword ?? '',
                              style: textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              keywordDetail.definition![0].definition ?? '',
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        color: secondaryBackgroundColor,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = keywordDetail.definition![index];
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
                                    Text(formatDateTime(item.createdAt ?? '')),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  item.definition?.trim() ?? '',
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
                                            title: 'Hapus Deskripsi',
                                            message:
                                                'Deskripsi yang dihapus tidak bisa dipulihkan kembali',
                                            onTapPrimaryButton: () {
                                              keywordsDetailCubit
                                                  .deleteOneKeywordDefinition(
                                                      id: item.id!);
                                              navigatorKey.currentState!.pop();
                                            },
                                          );
                                        },
                                        style: FilledButton.styleFrom(
                                          backgroundColor: dangerColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          AssetPath.getIcon("trash.svg"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: keywordDetail.definition!.length,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
