import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/common/style.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

const String baseUrl = "http://35.73.30.144:2005/api/v1";

// ✅ Helper function to get headers dynamically
Future<Map<String, String>> getHeaders() async {
  String? token =await HiveDB.retrieveLoginToken();
  return {
    "Content-Type": "application/json",
    "token": token ?? "",
  };
}

// ✅ Fetch New Tasks (Improved)
Future<List> getNewTask() async {
  try {
    final response = await http.get(Uri.parse("$baseUrl/listTaskByStatus/New"),
        headers: await getHeaders());

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        return responseBody["data"];
      }
    }
  } catch (e) {
    errorToast("Failed to fetch new tasks");
  }
  return [];
}

// ✅ Create a New Task (More Secure)
Future<void> createNewTaskService(Map<String, dynamic> taskData) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/createTask"),
      headers: await getHeaders(),
      body: jsonEncode(taskData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        successToast("Task created successfully");
        return;
      }
    }
  } catch (e) {
    errorToast("Task creation failed");
  }
}

// ✅ Update Task Status
Future<void> updateTaskStatus(String taskId) async {
  try {
    final response = await http.get(
      Uri.parse("$baseUrl/updateTaskStatus/$taskId/Completed"),
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        successToast("Task marked as completed");
        return;
      }
    }
  } catch (e) {
    errorToast("Failed to update task status");
  }
}

// ✅ Fetch Completed Tasks
Future<List> getCompletedTask() async {
  try {
    final response = await http.get(Uri.parse("$baseUrl/listTaskByStatus/Completed"),
        headers: await getHeaders());

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        return responseBody["data"];
      }
    }
  } catch (e) {
    errorToast("Failed to fetch completed tasks");
  }
  return [];
}
