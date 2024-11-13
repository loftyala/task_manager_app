import 'package:get/get.dart';

import '../Data/Model/loginModel.dart';
import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';
import 'auth_controller.dart';

class SingInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return response.isSuccess;
  }
}
