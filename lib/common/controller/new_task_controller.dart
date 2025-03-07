import 'package:get/get.dart';

import '../../task-management/data/services/user_task_service.dart';

class NewTaskController extends GetxController{
  List newTask = [].obs;
  fetchNewTask() async {
    var Task = await getNewTask();
    newTask.assignAll(Task);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNewTask();
  }
}