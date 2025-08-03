import 'package:get/get.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../../data/models/models/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';
import 'auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    String? password,
    Uint8List? photo,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, String> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password != null) {
      requestBody['password'] = password;
    }
    if (photo != null) {
      requestBody['photo'] = base64Encode(photo);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Url.getUpdateProfileUrl,
      body: requestBody,
    );
    _inProgress = false;
    update();
    if (response.isSuccess) {
      UserModel userModel = UserModel(
        id: AuthController.userModel!.id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: photo == null
            ? AuthController.userModel?.photo
            : base64Encode(photo),
      );
      await AuthController.updateUserData(userModel);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }
    return isSuccess;
  }
}
