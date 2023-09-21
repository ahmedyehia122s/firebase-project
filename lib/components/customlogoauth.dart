import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.red[200],
        radius: 50,
        child: Image.asset('images/notepad.png', width: 60),
      ),
    );
  }
}
