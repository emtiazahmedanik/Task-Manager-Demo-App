

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

  static void storeRegistration() {
    box.put("registration", true);
  }

  static bool retrieveRegistrationFlag() {
    return box.get("registration", defaultValue: false);
  }

  static void storeLoginToken(String token) {
    box.put("login", token);
  }

  static String? retrieveLoginToken() {
    return box.get("login");
  }
}
