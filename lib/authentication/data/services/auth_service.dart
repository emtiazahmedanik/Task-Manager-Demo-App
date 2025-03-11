import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/common/style.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

const String baseUrl = "http://35.73.30.144:2005/api/v1";

// API Endpoints
final Uri registrationUri = Uri.parse("$baseUrl/Registration");
final Uri loginUri = Uri.parse("$baseUrl/Login");
final Uri profileDetailUri = Uri.parse("$baseUrl/ProfileDetails");

// ✅ Helper function to get headers dynamically
Future<Map<String, String>> getHeaders() async {
  String? token = await HiveDB.retrieveLoginToken();
  return {
    "Content-Type": "application/json",
    "token": token ?? "",
  };
}

// ✅ Register User (More Secure)
Future<bool> registerUser(Map<String, dynamic> fromJson) async {
  try {
    final response = await http.post(
      registrationUri,
      body: jsonEncode(fromJson),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        successToast("Registration Successful");
        return true;
      }
    }
  } catch (e) {
    errorToast("Registration Failed: ${e.toString()}");
  }
  return false;
}

// ✅ Login User (Stores Token Automatically)
Future<String> loginUser(Map<String, dynamic> fromJson) async {
  try {
    final response = await http.post(
      loginUri,
      body: jsonEncode(fromJson),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        String token = responseBody["token"];
        successToast("Login Successful");
        return token;
      }
    }
  } catch (e) {
    errorToast("Login Failed: ${e.toString()}");
  }
  return "";
}

// ✅ Get Profile Details (More Reliable)
Future<List> getProfileDetail() async {
  try {
    final response = await http.get(profileDetailUri, headers: await getHeaders());

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["status"] == "success") {
        return responseBody["data"];
      }
    }
  } catch (e) {
    errorToast("Failed to fetch profile details");
  }
  return [];
}
