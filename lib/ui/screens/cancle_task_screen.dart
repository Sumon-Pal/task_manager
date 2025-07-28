import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import '../../data/services/network_caller.dart';
import '../../data/services/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCancleTaskList();
  }
  bool _getCancleTaskListInProgress = false;
  List<TaskModel> _cancleTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: _getCancleTaskListInProgress == false,
        replacement: CenterCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _cancleTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(taskType: TaskType.cancelled, taskModel: _cancleTaskList[index], onStatusUpdate: () { _getCancleTaskList(); },);
          },
        ),
      ),
    );
  }
  Future<void> _getCancleTaskList()async{

    _getCancleTaskListInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(url: Url.getCancelledTaskUrl);

    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancleTaskList = list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getCancleTaskListInProgress = false;
    setState(() {});

  }
}
