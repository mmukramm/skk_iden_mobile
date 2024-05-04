// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';

import 'package:skk_iden_mobile/core/preferences/asset_helper.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/sign_in_check_cubit.dart';
import 'package:skk_iden_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:skk_iden_mobile/features/home/home_page.dart';
import 'package:skk_iden_mobile/features/keywords/keywords_page.dart';
import 'package:skk_iden_mobile/features/users/users_page.dart';

class SkkIden extends StatefulWidget {
  const SkkIden({super.key});

  @override
  State<SkkIden> createState() => _SkkIdenState();
}

class _SkkIdenState extends State<SkkIden> {
  late int selectedPage;
  late final List<Widget> pages;
  late final SignOutCubit signOutCubit;

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    signOutCubit = context.read<SignOutCubit>();
    pages = [
      const HomePage(),
      const KeywordstPage(),
      const UsersPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, DataState<bool>>(
      listener: (_, state) {
        if (state.isSuccess) {
          CredentialSaver.accessToken = null;
          CredentialSaver.userInfoModel = null;
          navigatorKey.currentState!.pop();
          navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }

        if (state.isFailure) {
          context.showSnackBar(message: state.message ?? "");
        }

        if (state.isInProgress) {
          context.showLoadingDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            AssetPath.getImage("logo_iden.png"),
            height: 32,
          ),
          backgroundColor: primaryBackgroundColor,
        ),
        drawer: _buildDrawer(),
        body: pages[selectedPage],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => navigatorKey.currentState!.pop(),
                    icon: const Icon(Icons.close),
                    color: primaryBackgroundColor,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang,",
                          style: textTheme.titleMedium!
                              .copyWith(color: secondaryBackgroundColor),
                        ),
                        Text(
                          CredentialSaver.userInfoModel!.name ?? "",
                          style: textTheme.bodyLarge!.copyWith(
                            color: primaryBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CredentialSaver.userInfoModel!.isAdmin!
                      ? _withMenuNavigation()
                      : const SizedBox(),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    navigatorKey.currentState!.pop();
                    signOutCubit.signOut();
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: dangerColor,
                      ),
                    ),
                  ),
                  child: Text(
                    "Logout",
                    style: textTheme.bodyLarge!.copyWith(
                      color: dangerColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _withMenuNavigation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Menu",
            style: textTheme.titleMedium!
                .copyWith(color: secondaryBackgroundColor),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomListTile(
          isSelected: selectedPage == 0,
          title: "Home",
          iconName: "home.svg",
          onTap: () {
            if (selectedPage != 0) {
              navigatorKey.currentState!.pop();
              setState(() {
                selectedPage = 0;
              });
            }
          },
        ),
        const SizedBox(
          height: 12,
        ),
        CustomListTile(
          isSelected: selectedPage == 1,
          title: "Input",
          iconName: "input.svg",
          onTap: () {
            if (selectedPage != 1) {
              navigatorKey.currentState!.pop();
              setState(() {
                selectedPage = 1;
              });
            }
          },
        ),
        const SizedBox(
          height: 12,
        ),
        CustomListTile(
          isSelected: selectedPage == 2,
          title: "Users",
          iconName: "user.svg",
          onTap: () {
            if (selectedPage != 2) {
              navigatorKey.currentState!.pop();
              setState(() {
                selectedPage = 2;
              });
            }
          },
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  final bool isSelected;
  final String title, iconName;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.iconName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      selectedTileColor: primaryBackgroundColor,
      leading: SvgPicture.asset(
        AssetPath.getIcon(iconName),
        colorFilter: ColorFilter.mode(
          isSelected ? primaryColor : primaryBackgroundColor,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: textTheme.titleMedium!.copyWith(
          color: isSelected ? primaryColor : primaryBackgroundColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
