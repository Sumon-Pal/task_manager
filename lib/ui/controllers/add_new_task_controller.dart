import 'package:get/get.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask({
    required String title,
    required String description,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      'title': title,
      'description': description,
      'status': 'New',
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Url.addNewTaskUrl,
      body: requestBody,
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    return isSuccess;
  }
}
