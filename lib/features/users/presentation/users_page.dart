import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/date_formatter.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/features/users/data/models/user_model.dart';
import 'package:skk_iden_mobile/features/users/presentation/bloc/users_cubit.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final formKey = GlobalKey<FormBuilderState>();
  late final UsersCubit usersCubit;

  @override
  void initState() {
    super.initState();
    usersCubit = context.read<UsersCubit>();
    usersCubit.getListUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Text(
                "Daftar User",
                style: textTheme.titleLarge!.copyWith(
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.showAddUserDialog(
                      title: 'Tambah User',
                      onTapPrimaryButton: () {},
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
                        "Tambah User",
                        style: textTheme.titleSmall!.copyWith(
                          color: scaffoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<UsersCubit, DataState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.isInProgress) {
                    return const Loading(
                      color: primaryColor,
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.data.length,
                    itemBuilder: (_, index) {
                      final user = UserModel.fromMap(state.data[index]);
                      return AdminItem(
                        userModel: user,
                      );
                    },
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

class AdminItem extends StatelessWidget {
  final UserModel? userModel;
  const AdminItem({
    super.key,
    this.userModel,
  });

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
            userModel?.name ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleLarge!.copyWith(color: primaryColor),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            userModel?.username ?? '',
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
              Text(userModel!.isAdmin ? 'Admin' : 'User'),
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
              Text(
                formatDateTime(userModel!.createdAt),
              ),
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
                      title: 'Hapus User?',
                      message:
                          'User yang dihapus tidak bisa dipulihkan kembali',
                      onTapPrimaryButton: () {},
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
                    context.showEditUserDialog(
                      title: 'Edit User',
                      onTapPrimaryButton: () {},
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: warningColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AssetPath.getIcon("pencil.svg"),
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
