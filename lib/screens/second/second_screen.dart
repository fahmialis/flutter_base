import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('2k screen'),
    );
  }
}
