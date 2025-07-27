import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';


class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];
  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible:_getProgressTaskInProgress == false,
        replacement: CenterCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(taskType: TaskType.progress, taskModel: _progressTaskList[index],);
          },
        ),
      ),
    );
  }
  Future<void> _getProgressTaskList()async{

    _getProgressTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(url: Url.getProgressTaskUrl);

    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getProgressTaskInProgress = false;
    setState(() {});

  }
}
