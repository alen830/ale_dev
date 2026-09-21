import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static late SharedPreferences _preferences;
  static const String _keyIsLogin = 'is_login';

  // Inisialisasi awal SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Setter untuk menyimpan status login
  static Future<bool> setLogin(bool value) async {
    return await _preferences.setBool(_keyIsLogin, value);
  }

  // Getter untuk mengambil status login (Default: false)
  static bool get isLogin {
    return _preferences.getBool(_keyIsLogin) ?? false;
  }

  // Method opsional untuk menghapus seluruh sesi/data jika diperlukan
  static Future<bool> clear() async {
    return await _preferences.clear();
  }
}
