import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/Data/Model/userModel.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';
  static String? accessToken;
  static UserModel? userData;

  // Save the access token
  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  // Save user data
  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      _userDataKey,
      jsonEncode(userModel.toJson()),
    );
    userData = userModel;
  }

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey); // Keep in sync
    return accessToken;
  }

  // Retrieve user data
  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData = sharedPreferences.getString(_userDataKey);
    if (userEncodedData == null) {
      return null;
    }
    userData = UserModel.fromJson(jsonDecode(userEncodedData));
    return userData;
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return accessToken != null;
  }

  // Clear only the access token (used for logout)
  static Future<void> clearAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    accessToken = null;
  }

  // Clear all user data (optional if you need a complete reset)
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    userData = null;
  }
}
