import 'package:shared_preferences/shared_preferences.dart';
import 'package:skk_iden_mobile/core/utils/const.dart';
import 'package:skk_iden_mobile/core/utils/credential_saver.dart';
import 'package:skk_iden_mobile/core/errors/exception.dart';

abstract class AuthPreferenceHelper {
  Future<String?> getAccessToken();
  Future<bool> setAccessToken(String accessToken);
  Future<bool> removeAccessToken();
}

class AuthPreferenceHelperImpl implements AuthPreferenceHelper {
  final SharedPreferences sharedPreferences;

  AuthPreferenceHelperImpl(this.sharedPreferences);

  @override
  Future<String?> getAccessToken() async {
    try {
      if (sharedPreferences.containsKey(accessTokenKey)) {
        final token = sharedPreferences.getString(accessTokenKey);

        CredentialSaver.accessToken ??= token;

        return token;
      } else {
        return null;
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> setAccessToken(String accessToken) async {
    try {
      return await sharedPreferences.setString(accessTokenKey, accessToken);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> removeAccessToken() async {
    try {
      return await sharedPreferences.remove(accessTokenKey);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
