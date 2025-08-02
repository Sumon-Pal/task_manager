import 'package:get/get.dart';
import '../../data/services/models/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn({required String email, required String password}) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String,String> requestBody ={
      'email':email,
      "password":password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(url: Url.loginUrl,body: requestBody,isFromLogin: true);
    if(response.isSuccess){
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];
      await AuthController.saveUserData(userModel, token);
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage!;
    }
      _inProgress == false;
      update();
      return isSuccess;
  }
}