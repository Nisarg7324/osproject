import 'package:flutter/material.dart';


//LRTF page stateful class
class LRTF extends StatefulWidget {
  @override
  _LRTFState createState() => _LRTFState();
}

class _LRTFState extends State<LRTF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('LRTF'),
          backgroundColor: Colors.red,
        ),
      );
  }
}