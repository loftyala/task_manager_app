import 'package:shared_preferences/shared_preferences.dart';

 const String _accessTokenKey = 'access_token';
 String? _accessToken;

class AuthController {
 static Future<void> saveAccessToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_accessTokenKey, token);
    _accessToken= token;
  }

 static Future<String?> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = await pref.getString(_accessTokenKey); // Retrieve the access token
    _accessToken= token;
    return token;
  }
 static bool isLoggedIn() {
    return _accessToken != null;
  }

static  Future<void> clearAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();// Remove the specific key
    _accessToken = null;
  }
}
