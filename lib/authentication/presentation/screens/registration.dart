import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/authentication/data/services/auth_service.dart';
import 'package:task_manager/authentication/presentation/screens/login.dart';
import 'package:task_manager/common/style.dart';
import 'package:task_manager/authentication/presentation/widgets/textformfield.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // State to show loading indicator

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Map<String, String> _getFormData() {
    return {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _phoneController.text.trim(),
      "password": _passwordController.text.trim(),
    };
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true); // Show loading indicator

    bool registered = await registerUser(_getFormData());

    if (registered) {
      await HiveDB.storeRegistration();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed. Try again.")),
      );
    }

    setState(() => _isLoading = false); // Hide loading indicator
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
                spacing: 7,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text("Create account", style: headingTextStyle()),
                  const SizedBox(height: 30),
                  buildTextFormField(_emailController, "Email", "Your Email"),
                  buildTextFormField(_firstNameController, "First Name", "Your first name"),
                  buildTextFormField(_lastNameController, "Last Name", "Your last name"),
                  buildTextFormField(_phoneController, "Phone", "Your phone number"),
                  buildTextFormField(_passwordController, "Password", "Enter password"),
                  const SizedBox(height: 20),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister, // Disable button when loading
                      style: elevatedButtonStyle(),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Register",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(fontSize: 16))),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      HiveDB.storeRegistration();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("Already Registered? Login",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(color: Colors.indigoAccent))),
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
