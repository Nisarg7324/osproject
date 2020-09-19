import 'package:flutter/material.dart';

import './main.dart';

class Fcfs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FCFS'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
               child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                 child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                   child: DataTable(
                     columns: [
                       DataColumn(label: Text('P'),numeric: false),
                       DataColumn(label: Text('AT'),numeric: true),
                       DataColumn(label: Text('BT'),numeric: true),
                       DataColumn(label: Text('CT'),numeric: true),
                       DataColumn(label: Text('TAT'),numeric: true),
                       DataColumn(label: Text('WT'),numeric: true),
                      ],
                    rows: [],
                  )
                ),
            )
          ),
            Row(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: (
                      FloatingActionButton(
                        child: Icon(
                          Icons.add,
                        ),
                      )
                  ),
                )
              ],
            ),

          ])
        ),
            );
  }
}

