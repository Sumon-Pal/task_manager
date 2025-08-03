import 'package:get/get.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';

class SetPasswordController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage=> _errorMessage;

  Future<bool> setPassword(String email, String password, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, String> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Url.setPasswordUrl,
      body: requestBody,
    );
    _inProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }
    return isSuccess;
  }
}