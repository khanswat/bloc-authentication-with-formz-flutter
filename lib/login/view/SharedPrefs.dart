import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  void getToken() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    var isLoggedIng = sharedPrefs.getString('token');
  }

  void setToken(String Token) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(
      'token',
      Token,
    );
  }

  void deleteToken() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.remove('token');
  }
}
