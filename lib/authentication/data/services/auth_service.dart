import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/authentication/presentation/screens/login.dart';
import 'package:task_manager/common/style.dart';

import '../../../common/local db/hivedb.dart';

final baseUrl = "http://35.73.30.144:2005/api/v1";
final registrationUri = Uri.parse("$baseUrl/Registration");
final loginUri = Uri.parse("$baseUrl/Login");
final profileDetailUri = Uri.parse("$baseUrl/ProfileDetails");

var token = HiveDB.retrieveLoginToken();

Future<bool> registerUser(fromJson) async{
  final postBody = jsonEncode(fromJson);
  final postHeader = {"Content-Type":"application/json"};
  final response = await http.post(registrationUri,body: postBody,headers: postHeader);
  final responseCode =response.statusCode;
  final responseBody = jsonDecode(response.body);
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast("Registration Successfully");
    return true;
  }else{
    errorToast("Registration Failed");
    return false;
  }
}

Future<String> loginUser(fromJson) async{
  final postBody = jsonEncode(fromJson);
  final postHeader = {"Content-Type":"application/json"};
  final response = await http.post(loginUri,body: postBody,headers: postHeader);
  final responseCode = response.statusCode;
  final responseBody = jsonDecode(response.body);
  var token = "";
  if(responseCode==200 && responseBody["status"]=="success"){
    successToast("Login Successfully");
    token = responseBody["token"];
    return token;
  }else{
    errorToast("Login Failed");
    return token;
  }
}

Future<List> getProfileDetail() async{
  final getHeader = {"token":"$token"};
  final response = await http.get(profileDetailUri,headers: getHeader);
  final responseBody = jsonDecode(response.body);
  if(response.statusCode==200 && responseBody["status"]=="success"){
    return responseBody["data"];
  }else{
    return [];

  }

}
