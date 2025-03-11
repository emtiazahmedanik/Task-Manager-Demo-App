import 'package:get/get.dart';
import '../../task-management/data/services/user_task_service.dart';

class NewTaskController extends GetxController {
  var newTask = <dynamic>[].obs; // ✅ Correct RxList usage

  // ✅ Fetch New Tasks with Error Handling
  Future<void> fetchNewTask() async {
    try {
      var task = await getNewTask(); // ✅ Correct variable naming
      if (task.isNotEmpty) {
        newTask.assignAll(task);
      } else {
        newTask.clear(); // ✅ Prevents stale data
      }
    } catch (e) {
      print("Error fetching new tasks: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNewTask(); // 🔥 Fetch tasks when controller initializes
  }
}
