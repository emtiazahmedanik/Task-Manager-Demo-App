import '../services/auth_service.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  // ✅ Factory constructor for better object creation
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      phone: json["mobile"] ?? "",
    );
  }
}

class CallApi {
  static Future<List<User>> callApi() async {
    try {
      final data = await getProfileDetail();
      return data.map((user) => User.fromJson(user)).toList();
        } catch (e) {
      debugPrint("Error fetching user data: $e");
      return [];
    }
  }
}
