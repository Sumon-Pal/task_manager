import 'package:flutter/material.dart';
import 'package:task_manager/data/services/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskType, required this.taskModel, required this.onStatusUpdate});

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;

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
              widget.taskModel.title,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            Text(widget.taskModel.description,
                style: TextStyle(color: Colors.grey)),
            Text('Date: ${widget.taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskChipLabel(widget.taskType),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getTaskChipColor(widget.taskType),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                Visibility(
                    visible: _updateTaskStatusInProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: IconButton(
                        onPressed: _showEditTaskStatusDialog,
                        icon: Icon(Icons.edit))),
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

  void _showEditTaskStatusDialog() {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: Text("Change Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('New'),
              trailing: _getTaskStatusTrailing(TaskType.tNew),
              onTap:(){
                if(widget.taskType==TaskType.tNew){
                  return;
                }
                _updateTaskStatus('New');
                },
            ),
            ListTile(
              title: Text('In Progress'),
              trailing: _getTaskStatusTrailing(TaskType.progress),
              onTap:(){
                if(widget.taskType==TaskType.progress){
                  return;
                }
                _updateTaskStatus('Progress');
              },
            ),
            ListTile(
              title: Text('completed'),
              trailing: _getTaskStatusTrailing(TaskType.completed),
              onTap:(){
                if(widget.taskType==TaskType.completed){
                return;
              }
              _updateTaskStatus('Completed');
                },
            ),
            ListTile(
              title: Text('cancelled'),
              trailing: _getTaskStatusTrailing(TaskType.cancelled),
              onTap:(){
                if(widget.taskType==TaskType.cancelled){
                  return;
                }
                _updateTaskStatus('Cancelled');
              },
            ),
          ],
        ),
      );
    });
  }

  Widget? _getTaskStatusTrailing(TaskType type) {
    return widget.taskType == type ? Icon(Icons.check) : null;
  }

  // void _onTapTaskStatus(String type) {
  //     if (type == widget.taskType) {
  //       return;
  //     }
  //     _updateTaskStatus(type.toString());
  //   }


    Future<void> _updateTaskStatus(String Status) async {
    Navigator.pop(context);
    _updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Url.getUpdateTaskStatusUrl(widget.taskModel.id, Status));
    _updateTaskStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }
}
