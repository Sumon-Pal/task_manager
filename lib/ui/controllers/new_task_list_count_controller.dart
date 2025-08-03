import 'package:get/get.dart';
import '../../data/models/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';

class NewTaskListCountController extends GetxController{
  bool _inProgress = false;
  List<TaskModel> _newTaskList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Url.getNewTaskUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress =false;
    update();
    return isSuccess;
  }
}