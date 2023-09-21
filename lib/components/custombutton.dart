import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String name;
  final Color color;
  final void Function() onpressed;
  const Custombutton(
      {super.key,
      required this.name,
      required this.color,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: onpressed,
      child: Text('$name',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }
}
