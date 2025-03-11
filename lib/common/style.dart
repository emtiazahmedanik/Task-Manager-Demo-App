import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:google_fonts/google_fonts.dart";

Color strokeColor = Color.fromRGBO(216, 218, 220, 1);
Color taskBackgroundColor =  Color.fromRGBO(243, 239, 238, 1);
Color selectionColor = Color.fromRGBO(159, 159, 159, 1);
headingTextStyle() {
  return GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

profileTextStyle(){
  return TextStyle(fontSize: 13,fontWeight: FontWeight.w500);
}

labelTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 14,
  );
}

hintTextStyle() {
  return GoogleFonts.inter(
      textStyle: TextStyle(color: strokeColor, fontSize: 16));
}

inputDecoration({hintext, labeltext}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: labeltext,
    labelStyle: labelTextStyle(),
    hintText: hintext,
    hintStyle: hintTextStyle(),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: strokeColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    enabledBorder: OutlineInputBorder(
      // When the field is enabled but not focused
      borderSide: BorderSide(color: strokeColor),
    ),
  );
}


elevatedButtonStyle(){
  return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(),
      elevation: 0
  );
}

successToast(text){
  return Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
errorToast(text){
  return Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}