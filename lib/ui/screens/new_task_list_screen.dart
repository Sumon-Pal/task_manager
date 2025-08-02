import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';
import 'package:task_manager/data/services/models/task_status_count_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_summary_card.dart';
import 'package:get/get.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNewTaskList();
      _getTaskStatusCountList();
    });
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
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenterCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountSummaryCard(
                      title: _taskStatusCountList[index].id,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 4),
                ),
              ),
            ),
            Visibility(
              visible: _getNewTaskInProgress == false,
              replacement: CenterCircularProgressIndicator(),
              child: Expanded(
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskType: TaskType.tNew,
                      taskModel: _newTaskList[index], onStatusUpdate: () {
                        _getNewTaskList();
                        _getTaskStatusCountList();
                    },
                    );
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
    // Navigator.pushNamed(context, AddNewTaskScreen.name);
    Get.toNamed(AddNewTaskScreen.name);
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Url.getNewTaskUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    } else {
      if(mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _getNewTaskInProgress=false;
    if(mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskStatusCountList() async {

    _getTaskStatusCountInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Url.getTaskStatusCountUrl,
    );

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
            }
      _taskStatusCountList = list;
    } else {
      if(mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getTaskStatusCountInProgress = false;
    if(mounted) {
      setState(() {});
    }
  }
}
