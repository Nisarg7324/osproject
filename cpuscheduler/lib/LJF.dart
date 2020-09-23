import 'package:flutter/material.dart';

import './main.dart';

class LJF extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ljfstate();
  }
}

class ljfstate extends State{
  var _counter=1;
  List<DataRow> _rowList = [
    DataRow(cells: <DataCell>[
      DataCell(Text('P1')),
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
      DataCell(Text('0')),
      DataCell(Text('0')),
      DataCell(Text('0')),
    ]),
  ];
  void _addrow(){
    setState(() {
      _counter++;
      _rowList.add(DataRow(
          cells: <DataCell>[
            DataCell(Text('P'+_counter.toString())),
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
            DataCell(Text('0')),
            DataCell(Text('0')),
            DataCell(Text('0')),
          ]
      ));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('LJF'),
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
                          rows: _rowList,
                        ),
                      ),
                    )
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: (
                          FloatingActionButton(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.add,
                            ),
                            onPressed: _addrow,
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

