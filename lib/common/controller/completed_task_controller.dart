import 'package:get/get.dart';
import 'package:task_manager/task-management/data/services/user_task_service.dart';

class CompletedTaskController extends GetxController {
  var completedTask = <dynamic>[].obs; // ✅ Correct RxList usage

  // ✅ Fetch Completed Tasks with Error Handling
  Future<void> fetchCompletedTask() async {
    try {
      var task = await getCompletedTask();
      if (task.isNotEmpty) {
        completedTask.assignAll(task);
      } else {
        completedTask.clear();
      }
    } catch (e) {
      print("Error fetching completed tasks: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCompletedTask(); // 🔥 Automatically fetch data when controller is initialized
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
