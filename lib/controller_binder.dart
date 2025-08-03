import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/cancel_task_list_controller.dart';
import 'package:task_manager/ui/controllers/completed_task_list_controller.dart';
import 'package:task_manager/ui/controllers/delete_task_controller.dart';
import 'package:task_manager/ui/controllers/forgot_password_email_controller.dart';
import 'package:task_manager/ui/controllers/new_task_list_count_controller.dart';
import 'package:task_manager/ui/controllers/pin_code_verification_controller.dart';
import 'package:task_manager/ui/controllers/progress_task_list_controller.dart';
import 'package:task_manager/ui/controllers/set_password_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/controllers/task_status_count_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';
import 'package:task_manager/ui/controllers/update_task_stasus_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
   Get.put(SignInController());
   Get.put(NewTaskListCountController());
   Get.put(TaskStatusCountController());
   Get.put(AddNewTaskController());
   Get.put(CancelTaskListController());
   Get.put(CompletedTaskListController());
   Get.put(ProgressTaskListController());
   Get.put(ForgotPasswordEmailController());
   Get.put(PinCodeVerificationController());
   Get.put(SetPasswordController());
   Get.put(SignInController());
   Get.put(UpdateProfileController());
   Get.put(UpdateTaskStatusController());
   Get.put(DeleteTaskController());
  }
}