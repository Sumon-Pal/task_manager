import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';

enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskType, required this.taskModel});

  final TaskType taskType;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(taskModel.description, style: TextStyle(color: Colors.grey)),
            Text('Date: ${taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskChipLabel(taskType),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getTaskChipColor(taskType),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor(TaskType type) {
    switch (type) {
      case TaskType.tNew:
        return Colors.blue;
      case TaskType.progress:
        return Colors.purple;
      case TaskType.completed:
        return Colors.green;
      case TaskType.cancelled:
        return Colors.red;
    }
  }

  String _getTaskChipLabel(TaskType type) {
    switch (type) {
      case TaskType.tNew:
        return 'New';
      case TaskType.progress:
        return 'In Progress';
      case TaskType.completed:
        return 'Completed';
      case TaskType.cancelled:
        return 'Cancelled';
    }
  }
}
