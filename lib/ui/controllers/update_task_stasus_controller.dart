import 'package:get/get.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';

class UpdateTaskStatusController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> updateTaskStatus(String id, String Status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Url.getUpdateTaskStatusUrl(id, Status),
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
