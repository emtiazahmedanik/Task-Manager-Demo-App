import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../authentication/data/model/profile_detail_model.dart';

class ProfileDetailController extends GetxController {
  var userDetailList = <User>[].obs; // ✅ Correct RxList usage

  // ✅ Fetch Profile Details with Error Handling
  Future<void> fetchProfileDetail() async {
    try {
      var data = await CallApi.callApi(); // Make sure CallApi.callApi() is correct
      if (data.isNotEmpty) {
        userDetailList.assignAll(data);
        debugPrint("Controller Data: ${userDetailList[0].firstName}");
      } else {
        userDetailList.clear(); // ✅ Prevents stale data
        debugPrint("No user details found.");
      }
    } catch (e) {
      debugPrint("Error fetching profile details: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetail(); // 🔥 Fetch user details when the controller initializes
  }
}
