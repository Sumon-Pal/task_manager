import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: _getCompletedTaskInProgress == false,
        replacement: CenterCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
           return TaskCard(taskType: TaskType.completed, taskModel: _completedTaskList[index],);
          },
        ),
      ),
    );
  }
  Future<void> _getCompletedTaskList()async{

    _getCompletedTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(url: Url.getCompletedTaskUrl);

    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList = list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getCompletedTaskInProgress = false;
    setState(() {});

  }
}
