import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/controller/profile_detail_controller.dart';

class ProfileDetailPage extends StatelessWidget {
   ProfileDetailPage({super.key});

  var profileDetailController = Get.put(ProfileDetailController());
  @override
  Widget build(BuildContext context) {
    final sH = MediaQuery.sizeOf(context).height;
    final sW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Material(
              elevation: 10,
              shadowColor: Colors.black45,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: sH*0.6,
                width: sW*0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Obx(()=>
                      Column(
                        spacing: 8,
                        children: [
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                          ),
                          RichText(text: TextSpan(
                              text: "Name: ",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: profileDetailController.userDetailList.isEmpty?"": "${profileDetailController.userDetailList[0].firstName} ${profileDetailController.userDetailList[0].lastName}  ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                              ]
                          )),
                          RichText(text: TextSpan(
                              text: "Phone: ",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: profileDetailController.userDetailList.isEmpty?"": "${profileDetailController.userDetailList[0].phone} ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600))
                              ]
                          )),
                          RichText(text: TextSpan(
                              text: "Email: ",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: profileDetailController.userDetailList.isEmpty?"": "${profileDetailController.userDetailList[0].email} ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600))
                              ]
                          ))
                        ],
                      )
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
