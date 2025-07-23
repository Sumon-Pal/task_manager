import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/controlers/auth_controler.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_summery_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getNewTaskInProgress = false;
  //bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  //List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 101,
              child: ListView.separated(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TaskCountSammeryCard(title: 'Progress', count: 13);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 4),
              ),
            ),
            Visibility(
              visible: _getNewTaskInProgress == false,
              replacement:CenterCircularProgressIndicator(),
              child: Expanded(
                child: ListView.builder(
                  itemCount:_newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(taskType: TaskType.tNew, taskModel:_newTaskList[index],);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTabAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTabAddNewTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
  Future<void> _getNewTaskList()async{
    print(AuthController.accessToken);
    _getNewTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(url: Url.getNewTaskUrl);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getNewTaskInProgress;
    setState(() {});
  }
}
