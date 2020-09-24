import 'package:flutter/material.dart';

//RR page stateful class
class RR extends StatefulWidget {
  @override
  _RRState createState() => _RRState();
}

class _RRState extends State<RR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('RR',style: TextStyle(fontFamily:'Pacifico'),),
        backgroundColor: Colors.red,
      ),
    );
  }
}
