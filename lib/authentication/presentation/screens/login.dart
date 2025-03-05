import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/authentication/data/services/auth_service.dart';
import 'package:task_manager/authentication/presentation/screens/task_home_page.dart';
import 'package:task_manager/authentication/presentation/style.dart';
import 'package:task_manager/authentication/presentation/widgets/textformfield.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _RegistrationPageState();
}

final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

Map<String,String> json = {
  "email":"",
  "password":""
};

updateJson(){
  json.update("email", (value)=>_emailController.text.toString());
  json.update("password", (value)=>_passwordController.text.toString());
}

var token = "";



class _RegistrationPageState extends State<LoginPage> {

  nextRoute(){
    setState(() {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskHomePage()));
    });

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
                    Text("Login",style: headingTextStyle(),),
                    SizedBox(height: 30,),
                    buildTextFormField(_emailController, "Email", "Your Email"),
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
                            token = await loginUser(json);
                            if(token.isNotEmpty){
                              HiveDB.storeLogin(token);
                              nextRoute();
                            }

                          }
                        },
                        style: elevatedButtonStyle(),
                        child: Text("Login",style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 16)),),
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
