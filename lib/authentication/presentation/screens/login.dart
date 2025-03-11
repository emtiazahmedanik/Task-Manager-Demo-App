import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/authentication/data/services/auth_service.dart';
import 'package:task_manager/task-management/presentation/screens/task_home_page.dart';
import 'package:task_manager/common/style.dart';
import 'package:task_manager/authentication/presentation/widgets/textformfield.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Loading indicator

  Map<String, String> _updateJson() {
    return {
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
    };
  }

  void _nextRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TaskHomePage()));
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true); // Show loading

      String token = await loginUser(_updateJson());
      if (token.isNotEmpty) {
        await HiveDB.storeLoginToken(token);
        _nextRoute();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed. Please try again.")),
        );
      }

      setState(() => _isLoading = false); // Hide loading
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 7,
                children: [
                  const SizedBox(height: 20),
                  Text("Login", style: headingTextStyle()),
                  const SizedBox(height: 30),
                  buildTextFormField(_emailController, "Email", "Your Email"),
                  buildTextFormField(_passwordController, "Password", "Enter password"),
                  const SizedBox(height: 20),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin, // Disable button when loading
                      style: elevatedButtonStyle(),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Login",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(fontSize: 16))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
