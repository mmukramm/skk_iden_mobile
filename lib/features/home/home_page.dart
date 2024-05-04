import 'package:flutter/material.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/auth/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> item = [
      "Makan",
      "Minum",
      "Tidur",
      "Main",
      "Makan Lagi",
    ];
    return Column(
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: CustomTextField(
            name: "keyword",
            labelText: "Cari Kata Kunci",
            labelTextAlign: TextAlign.center,
            hintText: "Masukkan kata kunci...",
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
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
                  itemCount: item.length,
                  itemBuilder: (_, index) {
                    return KeywordItem(
                      keyword: item[index],
                      onTap: () {
                        debugPrint("awooo ${item[index]}");
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
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
