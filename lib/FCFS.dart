import 'dart:math';
import 'package:flutter/material.dart';
import './FCFSIOBT.dart';
import './Card.dart';

//FCFS page stateful class
class FCFS extends StatefulWidget {
  @override
  _FCFSState createState() => _FCFSState();
}

class _FCFSState extends State<FCFS> {
  var _counter = 0;

  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];

  void _run(){
    int cal = 0, st = 0,_tt=0;
    List<bool> vis;
    vis = new List<bool>.filled(_counter, false);
    while (cal != _counter) {
      var mn = 100, loc = 0;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][0] < mn && !vis[i]) {
          mn = _data[i][0];
          loc = i;
        }
      }
      vis[loc] = true;
      cal++;
      _cardv[_tt][0]=loc;
      _cardv[_tt][1]=max(_data[loc][0], st);
      _data[loc][2] = max(_data[loc][0], st) + _data[loc][1];
      //_cardv.add([max(_data[loc][0], st),_data[loc][2]]);
      st = _data[loc][2];
      _cardv[_tt][2]= _data[loc][2];
      _cardv[_tt][3]=1;
      //print(max(_data[loc][0], st));
      //print(_data[loc][2]);
      //print(_cardv[loc][1]);
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - _data[loc][1];
      for (int i = 0; i < 5; ++i) _datas[loc][i] = _data[loc][i].toString();
      for (int i = 0; i < 4; ++i) _cardvs[_tt][i]=_cardv[_tt][i].toString();
      //print(_cardvs[loc][1]);
      _tt++;
    }
    print(_tt);
    print(_cardvs);
  }

  void _calculate() {
    int cal = 0, st = 0;
    List<bool> vis;
    vis = new List<bool>.filled(_counter, false);
    while (cal != _counter) {
      var mn = 100, loc = 0;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][0] < mn && !vis[i]) {
          mn = _data[i][0];
          loc = i;
        }
      }
      vis[loc] = true;
      cal++;
      _data[loc][2] = max(_data[loc][0], st) + _data[loc][1];
      st = _data[loc][2];
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - _data[loc][1];
      for (int i = 0; i < 5; ++i) _datas[loc][i] = _data[loc][i].toString();
      int t = loc;
      _rowList[loc] = DataRow(cells: <DataCell>[
        DataCell(
            Text('P' + t.toString(), style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][0] = val;
              _data[t][0] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][1] = val;
            _data[t][1] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][2], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][3], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
      ]);
    }
  }

  void _addrow() {
    setState(() {
      var t = _counter;
      _counter++;
      _data.add([0, 0, 0, 0, 0]);
      _cardv.add([0,0,0,0]);
      _datas.add(['0', '0', '0', '0', '0']);
      _cardvs.add(['0','0', '0','0']);
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(Text('P' + (_counter - 1).toString(),
            style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][0] = val;
              _data[t][0] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][1] = val;
            _data[t][1] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][2], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][3], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
      ]));
    });
  }

  void _RemoveRow() {
    setState(() {
      _counter--;
      _rowList.removeLast();
      _data.removeLast();
      _datas.removeLast();
      _calculate();
    });
  }

  var f = true;
  @override
  Widget build(BuildContext context) {
    if (f) {
      _addrow();
      f = false;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'FCFS',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Padding(
                child: Align(
                  child: Text('I/O Device',style: TextStyle(color: Colors.white ,fontSize: 20),),
                  alignment: Alignment.topRight,
                ),
                padding: EdgeInsets.only(right: 30),
              ),
              Padding(
                child: Align(
                  child: Switch(
                      value: false,
                      onChanged: (t) {
                        Navigator.pop(context);
                        // Navigator.of(context).push(FCFSIOBT());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FCFSIOBT()),
                        );
                      }),
                  alignment: Alignment.topRight,
                ),
                padding: EdgeInsets.only(right: 30),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('P',
                                style: TextStyle(color: Colors.white)),
                            numeric: false),
                        DataColumn(
                            label: Text('AT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('BT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('CT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('TAT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                        DataColumn(
                            label: Text('WT',
                                style: TextStyle(color: Colors.white)),
                            numeric: true),
                      ],
                      rows: _rowList,
                    ),
                  ),
                ),
              ),
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
                        onPressed: (){
                          _run();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CARD(_cardvs),
                          ));

                        },
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
                      onPressed: _RemoveRow,
                    )),
                  )
                ],
              ),
              Container(height:700),
            ],
          ),
        ));
  }
}