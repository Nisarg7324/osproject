import 'package:flutter/material.dart';

import './main.dart';

class FCFS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FCFSstate();
  }
}

class FCFSstate extends State {
  var _counter = 1;
  List<DataRow> _rowList = [
    DataRow(cells: <DataCell>[
      DataCell(Text(
        'P1',
        style: TextStyle(color: Colors.white),
      )),
      DataCell(TextField(
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
      )),
      DataCell(TextField(
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
      )),
      DataCell(Text('0', style: TextStyle(color: Colors.white))),
      DataCell(Text('0', style: TextStyle(color: Colors.white))),
      DataCell(Text('0', style: TextStyle(color: Colors.white))),
    ]),
  ];
  void _addrow() {
    setState(() {
      _counter++;
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(Text('P' + _counter.toString(),
            style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
        )),
        DataCell(Text('0', style: TextStyle(color: Colors.white))),
        DataCell(Text('0', style: TextStyle(color: Colors.white))),
        DataCell(Text('0', style: TextStyle(color: Colors.white))),
      ]));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('FCFS'),
        backgroundColor: Colors.red,
      ),
      body: Container(
          child: Column(children: <Widget>[
        Container(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text('P', style: TextStyle(color: Colors.white)),
                    numeric: false),
                DataColumn(
                    label: Text('AT', style: TextStyle(color: Colors.white)),
                    numeric: true),
                DataColumn(
                    label: Text('BT', style: TextStyle(color: Colors.white)),
                    numeric: true),
                DataColumn(
                    label: Text('CT', style: TextStyle(color: Colors.white)),
                    numeric: true),
                DataColumn(
                    label: Text('TAT', style: TextStyle(color: Colors.white)),
                    numeric: true),
                DataColumn(
                    label: Text('WT', style: TextStyle(color: Colors.white)),
                    numeric: true),
              ],
              rows: _rowList,
            ),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: (RaisedButton(
                onPressed: _addrow,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red),
                ),
                child: Text(
                  'Add Process',
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: (RaisedButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red),
                ),
                child: Text(
                  'Run',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: null,
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: (RaisedButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red),
                ),
                child: Text(
                  'Delete Process',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: null,
              )),
            )
          ],
        ),
      ])),
    );
  }
}
