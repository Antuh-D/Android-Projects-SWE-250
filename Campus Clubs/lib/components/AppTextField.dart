import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget{
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;


  const AppTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTexts.normal,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor:Colors.white.withOpacity(0.9),
      ),


    );
  }

}