import 'dart:convert';

import 'package:task_manager/common/style.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';
import 'package:http/http.dart' as http;

final baseUrl = "http://35.73.30.144:2005/api/v1";
Uri completedTaskUri = Uri.parse("$baseUrl/listTaskByStatus/Completed");
Uri newTaskUri = Uri.parse("$baseUrl/listTaskByStatus/New");
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
