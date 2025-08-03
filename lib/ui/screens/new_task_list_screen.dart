import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/new_task_list_count_controller.dart';
import 'package:task_manager/ui/controllers/task_status_count_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_summary_card.dart';
import 'package:get/get.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<NewTaskListCountController>().getNewTaskList();
      Get.find<TaskStatusCountController>().getTaskStatusCountList();
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
              child: GetBuilder<TaskStatusCountController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ListView.separated(
                      itemCount: controller.taskStatusCountList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TaskCountSummaryCard(
                          title: controller.taskStatusCountList[index].id,
                          count: controller.taskStatusCountList[index].count,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 4),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GetBuilder<NewTaskListCountController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: controller.newTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskType: TaskType.tNew,
                            taskModel: controller.newTaskList[index],
                            onStatusUpdate: () {
                              Get.find<NewTaskListCountController>()
                                  .getNewTaskList();
                              Get.find<TaskStatusCountController>()
                                  .getTaskStatusCountList();
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
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
    Get.toNamed(AddNewTaskScreen.name);
  }
}
