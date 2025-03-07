import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:task_manager/authentication/presentation/screens/login.dart';
import 'package:task_manager/authentication/presentation/screens/registration.dart';
import 'package:task_manager/task-management/presentation/screens/task_home_page.dart';
import 'package:task_manager/common/local%20db/hivedb.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("storage");
  await HiveDB.initializeHive();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var flagRegister ;
  var flagLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flagRegister = HiveDB.retrieveRegistrationFlag();
    flagLogin = HiveDB.retrieveLoginToken();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:flagRegister==null ? (RegistrationPage()) : (flagRegister?(flagLogin==null?LoginPage():TaskHomePage()):RegistrationPage()),
    );
  }
}

