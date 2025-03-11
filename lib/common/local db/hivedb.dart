import 'package:hive_ce/hive.dart';

class HiveDB {
  static late Box box;

  /// Initialize Hive once when the app starts
  static Future<void> initializeHive() async {
    if (!Hive.isBoxOpen("storage")) {
      box = await Hive.openBox("storage");
    } else {
      box = Hive.box("storage");
    }
  }

  /// Store registration flag
  static Future<void> storeRegistration() async {
    await box.put("registration", true);
  }

  /// Retrieve registration flag asynchronously
  static Future<bool> retrieveRegistrationFlag() async {
    return await box.get("registration", defaultValue: false);
  }

  /// Store login token
  static Future<void> storeLoginToken(String token) async {
    await box.put("login", token);
  }

  /// Retrieve login token asynchronously
  static Future<String?> retrieveLoginToken() async {
    return await box.get("login");
  }
}
