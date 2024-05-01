import 'package:skk_iden_mobile/features/auth/data/datasources/auth_preference_helper.dart';
import 'package:skk_iden_mobile/features/auth/data/models/user_info_model.dart';
import 'package:skk_iden_mobile/injection_container.dart';

class CredentialSaver {
  static String? accessToken;
  static UserInfoModel? userInfoModel;

  static Future<void> init() async {
    if (accessToken == null) {
      AuthPreferenceHelper preferencesHelper = getIt();

      accessToken = await preferencesHelper.getAccessToken();
    }
  }
}