import 'package:flutter/material.dart';


//FCFS page stateful class
class FCFS extends StatefulWidget {
  @override
  _FCFSState createState() => _FCFSState();
}

class _FCFSState extends State<FCFS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('FCFS'),
          backgroundColor: Colors.red,
        ),
      );
  }
}