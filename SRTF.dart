import 'package:flutter/material.dart';


//SRTF page stateful class
class SRTF extends StatefulWidget {
  @override
  _SRTFState createState() => _SRTFState();
}

class _SRTFState extends State<SRTF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('SRTF'),
          backgroundColor: Colors.red,
        ),
      );
  }
}