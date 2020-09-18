import 'package:flutter/material.dart';


//LJF page stateful class
class LJF extends StatefulWidget {
  @override
  _LJFState createState() => _LJFState();
}

class _LJFState extends State<LJF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('LJF'),
          backgroundColor: Colors.red,
        ),
      );
  }
}