import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProgressTaskListController>().getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<ProgressTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: CenterCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.progressTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.progress,
                  taskModel: controller.progressTaskList[index],
                  onStatusUpdate: () {
                    Get.find<ProgressTaskListController>()
                        .getProgressTaskList();
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
