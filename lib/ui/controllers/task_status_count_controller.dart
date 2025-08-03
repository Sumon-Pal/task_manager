import 'package:get/get.dart';
import '../../data/models/models/task_status_count_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';

class TaskStatusCountController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> getTaskStatusCountList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Url.getTaskStatusCountUrl,
    );

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
