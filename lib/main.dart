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

  bool? flagRegister;
  String? flagLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeFlags();
  }

  Future<void> _initializeFlags() async {
    var registerFlag = await HiveDB.retrieveRegistrationFlag();
    var loginFlag = await HiveDB.retrieveLoginToken();

    setState(() {
      flagRegister = registerFlag;
      flagLogin = loginFlag;
    });
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
      home: flagRegister == null
          ? const Center(child: CircularProgressIndicator()) // Prevents null errors
          : (flagRegister!
          ? (flagLogin == null ? LoginPage() : TaskHomePage())
          : RegistrationPage()),
    );
  }
}

