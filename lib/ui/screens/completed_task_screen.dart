import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
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
    Get.find<CompletedTaskListController>().getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CompletedTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: CenterCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.completed,
                  taskModel: controller.completedTaskList[index],
                  onStatusUpdate: () {
                    Get.find<CompletedTaskListController>()
                        .getCompletedTaskList();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
