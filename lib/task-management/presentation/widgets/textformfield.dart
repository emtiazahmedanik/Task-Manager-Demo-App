import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTextFormField({required labelText,required hintText,required controller}){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16,color: Colors.black)),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14,color: Colors.grey))
    ),
    validator: (value){
      if(value==null || value.isEmpty){
        return "Enter $labelText";
      }else{
        return null;
      }
    },
  );
}