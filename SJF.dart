import 'package:flutter/material.dart';


//SJF page stateful class
class SJF extends StatefulWidget {
  @override
  _SJFState createState() => _SJFState();
}

class _SJFState extends State<SJF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('SJF'),
          backgroundColor: Colors.red,
        ),
      );
  }
}