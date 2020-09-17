import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
	runApp(MaterialApp(
		home: Home(),
	));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      backgroundColor: Colors.black,
			appBar: AppBar(
				title: Text("Scheduling Algorithm"),
				centerTitle: true,
				backgroundColor: Colors.red,
        elevation: 0.0,
			),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text("CPU Scheduling is a process of determining which process will own CPU for execution while another process is on hold. The main task of CPU scheduling is to make sure that whenever the CPU remains idle, the OS at least select one of the processes available in the ready queue for execution. The selection process will be carried out by the CPU scheduler. It selects one of the processes in memory that are ready for execution.", textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          Divider(
            height: 0,
            color: Colors.grey[850],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("FCFS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                  padding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(width: 40.0),
              Expanded(
                flex: 4,
                child:  RaisedButton(
                  onPressed: () {},
                  child: Text("SJF",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                  padding: EdgeInsets.all(15),
               ),
              ),
            ],
          ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex:4,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("SRTF",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.redAccent),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                ),
                SizedBox(width: 40.0),
                Expanded(
                  flex: 4,
                  child:  RaisedButton(
                    onPressed: () {},
                    child: Text("Round Robin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.redAccent),
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child:  RaisedButton(
                    onPressed: () {},
                    child: Text("Priority Scheduling\n(Preemptive)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.redAccent),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(width: 40.0),
                Expanded(
                  flex: 4,
                  child:  RaisedButton(
                    onPressed: () {},
                    child: Text("Priority Scheduling\n(Non-Preemptive)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.redAccent),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
        ],
      ),
      ),
		);
	}
}


