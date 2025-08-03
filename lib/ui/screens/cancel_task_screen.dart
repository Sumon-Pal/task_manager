import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/cancel_task_list_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import '../widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CancelTaskListController>().getCancelTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CancelTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: CenterCircularProgressIndicator(),
            child: ListView.builder(
              itemCount: controller.cancelTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.cancelled,
                  taskModel: controller.cancelTaskList[index],
                  onStatusUpdate: () {
                    Get.find<CancelTaskListController>().getCancelTaskList();
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
