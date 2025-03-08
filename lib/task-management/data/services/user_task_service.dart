import 'dart:convert';

import 'package:task_manager/common/style.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';
import 'package:http/http.dart' as http;

final baseUrl = "http://35.73.30.144:2005/api/v1";
Uri completedTaskUri = Uri.parse("$baseUrl/listTaskByStatus/Completed");
Uri newTaskUri = Uri.parse("$baseUrl/listTaskByStatus/New");
Uri createTaskUri = Uri.parse("$baseUrl/createTask");


var token = HiveDB.retrieveLoginToken();

Future<List> getNewTask() async{
  final getHeader = {"token":"$token"};
  final response = await http.get(newTaskUri,headers: getHeader);
  final responseCode = response.statusCode;
  final responseBody = jsonDecode(response.body);
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast("New Task Fetch Successfully");
    return responseBody["data"];

  }else{
    errorToast("Failed to fetch new task");
    return [];

  }
}
Future<void> createNewTaskService(fromJson) async{
  final postHeader = {"Content-Type":"application/json","token":"$token"};
  final postBody = jsonEncode(fromJson);
  final response = await http.post(createTaskUri,headers: postHeader,body: postBody);
  final responseCode = response.statusCode;
  final responseBody = jsonDecode(response.body);
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast("Task created successfully");

  }else{
    errorToast("Task creation failed");
  }
}

Future<void> updateTaskStatus(id)async{
  Uri completedTaskIdUri = Uri.parse("$baseUrl/updateTaskStatus/$id/Completed");
  final getHeader = {"token":"$token"};
  final response = await http.get(completedTaskIdUri,headers: getHeader);
  final responseCode = response.statusCode;
  final responseBody = jsonDecode(response.body);
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast("Task Completed");
  }else{
    errorToast("Request Fail");
  }
}

Future<List> getCompletedTask() async{
  final getHeader = {"token":"$token"};
  final response = await http.get(completedTaskUri,headers: getHeader);
  final responseCode = response.statusCode;
  final responseBody = jsonDecode(response.body);
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast("Completed Task Fetched");
    return responseBody["data"];
  }else{
    errorToast("Request Fail");
    return [];
  }
}