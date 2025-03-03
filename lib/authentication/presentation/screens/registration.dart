import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:task_manager/authentication/data/services/auth_service.dart';
import 'package:task_manager/authentication/presentation/style.dart';
import 'package:task_manager/authentication/presentation/widgets/textformfield.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
final _phoneController = TextEditingController();
final _passwordController = TextEditingController();

bool registered = false;

Map<String,String> json = {
  "email":"",
  "firstName":"",
  "lastName":"",
  "mobile":"",
  "password":""
};

updateJson(){
  json.update("email",(value)=>_emailController.text.toString());
  json.update("firstName",(value)=>_firstNameController.text.toString());
  json.update("lastName",(value)=>_lastNameController.text.toString());
  json.update("mobile",(value)=>_phoneController.text.toString());
  json.update("password",(value)=>_passwordController.text.toString());
}


class _RegistrationPageState extends State<RegistrationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20,),
                    Text("Create account",style: headingTextStyle(),),
                    SizedBox(height: 30,),
                    buildTextFormField(_emailController, "Email", "Your Email"),
                    buildTextFormField(_firstNameController, "First Name", "Your first name"),
                    buildTextFormField(_lastNameController, "Last Name", "Your last name"),
                    buildTextFormField(_phoneController, "Phone", "Your phone number"),
                    buildTextFormField(_passwordController, "Password", "Enter password"),
                    SizedBox(height: 20,),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ElevatedButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            updateJson();
                            registered = await registerUser(json);
                            setState(() {
                              if(registered==true){
                                HiveDB.storeRegistration();
                              }
                            });
                          }
                        },
                        style: elevatedButtonStyle(),
                        child: Text("Register",style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 16)),),
                      ),
                    )
                  ],

                ),
              ),
            ),
          )
      ),
    );
  }
}
