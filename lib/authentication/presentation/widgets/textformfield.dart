
import 'package:flutter/material.dart';

import '../style.dart';

Widget buildTextFormField(TextEditingController controller,String label,String hintText){
  return TextFormField(
    decoration: inputDecoration(hintext: hintText,labeltext: label),
    controller: controller,
    cursorColor: Colors.black,
    obscureText: label=="Password"?true:false,
    keyboardType: label=="Phone"?TextInputType.number:TextInputType.text,
    validator: (value)=>(value==null || value.isEmpty)?"Enter $label":null,
  );
}