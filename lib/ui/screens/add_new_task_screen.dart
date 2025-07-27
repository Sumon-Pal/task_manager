import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  static final String name = '/add-new-task';

  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 42),
                  TextFormField(
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return 'Enter your Subject';
                      }
                      return null;
                    },
                    controller: _titleTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Subject'),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return 'Enter your description';
                      }
                      return null;
                    },
                    controller: _descriptionTEController,
                    textInputAction: TextInputAction.done,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapAddTask,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddTask() {
    if(_formKey.currentState!.validate()){
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String,String> requestBody ={
      'title':_titleTEController.text.trim(),
      'description':_descriptionTEController.text.trim(),
      'status':'New',
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url:Url.addNewTaskUrl,
      body: requestBody,
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if(response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      showSnackBarMessage(context, 'Added New Task');
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
