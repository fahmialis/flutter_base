import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  // Intentionally accessing a property that doesn't exist to trigger an error
  String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text!.toUpperCase()),
    );
  }
}
