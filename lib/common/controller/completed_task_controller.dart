import 'package:get/get.dart';
import 'package:task_manager/task-management/data/services/user_task_service.dart';

class CompletedTaskController extends GetxController{
  List completedTask = [].obs;
  fetchCompletedTask() async{
    var task = await getCompletedTask();
    completedTask.assignAll(task);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCompletedTask();
  }
}