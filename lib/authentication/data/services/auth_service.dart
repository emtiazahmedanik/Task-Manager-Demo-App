import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/authentication/presentation/style.dart';

final baseUrl = "http://35.73.30.144:2005/api/v1";
final registrationUri = Uri.parse("$baseUrl/Registration");
final loginUri = Uri.parse("$baseUrl/Login");

Future<bool> registerUser(fromJson) async{
  final postBody = jsonEncode(fromJson);
  final postHeader = {"Content-Type":"application/json"};
  final response = await http.post(registrationUri,body: postBody,headers: postHeader);
  final responseCode =response.statusCode;
  final responseBody = jsonDecode(response.body);
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast();
    return true;
  }else{
    errorToast();
    return false;
  }
}