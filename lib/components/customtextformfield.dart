import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController? myController;
  final String hinttext;
  final String? Function(String?)? validator;
  const CustomField(
      {super.key,
      required this.hinttext,
      this.myController,
      required this.obscureText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: myController,
      decoration: InputDecoration(
        hintText: hinttext,
        contentPadding: const EdgeInsets.only(left: 20),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
