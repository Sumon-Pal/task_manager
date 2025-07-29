class Url {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String addNewTaskUrl = '$_baseUrl/createTask';
  static const String getNewTaskUrl = '$_baseUrl/listTaskByStatus/New';
  static const String getProgressTaskUrl =
      '$_baseUrl/listTaskByStatus/Progress';
  static const String getCompletedTaskUrl =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String getCancelledTaskUrl =
      '$_baseUrl/listTaskByStatus/Cancelled';
  static const String getTaskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static const String getUpdateProfileUrl = '$_baseUrl/ProfileUpdate';

  static String getUpdateTaskStatusUrl(String taskId, String status)=>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
}
