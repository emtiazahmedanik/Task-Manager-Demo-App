import 'package:hive_ce/hive.dart';

class HiveDB{
  static var box = Hive.box("storage");
  static _initializeHive() async{
    if(!Hive.isBoxOpen("storage")){
      box = await Hive.openBox("storage");
    }else{
      box = Hive.box("storage");
    }
  }
  static storeRegistration(){
    _initializeHive();
    box.put("registration", true);
  }
  static dynamic retrieveRegistrationFlag(){
    _initializeHive();
    var value = box.get("registration");
    return value;
  }
}
