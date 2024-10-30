import 'package:flutter/material.dart';

Color color = Colors.orange.shade900;
Color colord = Colors.orange.shade800;
Color colore = Colors.orange.shade400;

List<Color> colors = [
  Colors.orange.shade900,
  Colors.orange.shade800,
  Colors.orange.shade400,
];

BoxDecoration boxDecoration(){
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(60),
      topRight: Radius.circular(60),
    ),
  );
}
InputDecoration inputDecoration(String hintText,label,icon){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
    fillColor: Colors.orange.shade800.withOpacity(.4),
    border: InputBorder.none,
    labelText: label,
    icon: icon,

  );
}
