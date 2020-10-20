import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './FCFS.dart';
import './Card.dart';
import './View.dart';

//FCFS page stateful class
class FCFSIOBT extends StatefulWidget {
  @override
  _FCFSIOBTState createState() => _FCFSIOBTState();
}

class _FCFSIOBTState extends State<FCFSIOBT> {
  var _counter = 0;

  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];
  List<List<bool>> _readyq=[];

  void _viz(){

  }

  void _Gant(){
    //print('running');
    _cardv.clear();
    _cardvs.clear();
    _readyq.clear();
    int cal = 0, st = 0,_tt=0;
    List<int> vis, artime;
    vis = new List<int>.filled(_counter, 0);
    artime = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) artime[i] = _data[i][0];
    while (cal != 2 * _counter) {
      _readyq.add(List.filled(_counter, false));
      var mn = 100,
          loc = 0;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][0] < mn && (vis[i] == 0 || vis[i] == 1)) {
          mn = _data[i][0];
          loc = i;
        }
        if((vis[i]==0 || vis[i]==1) && st>=_data[loc][0]){
          _readyq[_tt][i]=true;
        }
      }
      cal++;

      if (vis[loc] == 0) {
        _cardv.add([0, 0, 0, 0]);
        _cardvs.add(['0', '0', '0', '0']);
        _data[loc][7] = max(_data[loc][0], st) - _data[loc][0];
        _data[loc][4] = max(_data[loc][0], st) + _data[loc][1];
        _cardv[_tt][0]=loc;
        _cardv[_tt][1]=max(_data[loc][0], st);
        st = _data[loc][4];
        _cardv[_tt][2]=st;
        _cardv[_tt][3]=2;
        _data[loc][0] = _data[loc][4] + _data[loc][2];
      }
      if (vis[loc] == 1) {
        _cardv.add([0, 0, 0, 0]);
        _cardvs.add(['0', '0', '0', '0']);
        _data[loc][4] = max(_data[loc][0], st) + _data[loc][3];
        _cardv[_tt][0]=loc;
        _cardv[_tt][1]=max(_data[loc][0], st);
        st = _data[loc][4];
        _cardv[_tt][2]=st;
        _cardv[_tt][3]=1;
        _data[loc][5] = _data[loc][4] - artime[loc];
        _data[loc][6] = _data[loc][5] - _data[loc][1] - _data[loc][3];
      }
      for (int i = 0; i < 8; ++i) _datas[loc][i] = _data[loc][i].toString();
      for (int i = 0; i < 4; ++i) _cardvs[_tt][i]=_cardv[_tt][i].toString();
      vis[loc]++;
      _tt++;
    }
    for (int i = 0; i < _counter; ++i) _data[i][0] = artime[i];
  }

  void _calculate() {
    int cal = 0, st = 0;
    List<int> vis, artime;
    vis = new List<int>.filled(_counter, 0);
    artime = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) artime[i] = _data[i][0];
    while (cal != 2 * _counter) {
      var mn = 100, loc = 0;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][0] < mn && (vis[i] == 0 || vis[i] == 1)) {
          mn = _data[i][0];
          loc = i;
        }
      }
      cal++;
      if (vis[loc] == 0) {
        _data[loc][7] = max(_data[loc][0], st) - _data[loc][0];
        _data[loc][4] = max(_data[loc][0], st) + _data[loc][1];
        st = _data[loc][4];
        _data[loc][0] = _data[loc][4] + _data[loc][2];
      }
      if (vis[loc] == 1) {
        _data[loc][4] = max(_data[loc][0], st) + _data[loc][3];
        st = _data[loc][4];
        _data[loc][5] = _data[loc][4] - artime[loc];
        _data[loc][6] = _data[loc][5] - _data[loc][1] - _data[loc][3];
      }
      for (int i = 0; i < 8; ++i) _datas[loc][i] = _data[loc][i].toString();
      int t = loc;
      _rowList[loc] = DataRow(cells: <DataCell>[
        DataCell(
            Text('P' + t.toString(), style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          //expands: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(2),
          ],
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
        DataCell(TextField(
          maxLines: 1,
          //       inputFormatters:[
          //   LengthLimitingTextInputFormatter(2),
          // ],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            setState(() {
              _datas[t][2] = val;
              _data[t][2] = int.parse(val);
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
            setState(() {
              _datas[t][3] = val;
              _data[t][3] = int.parse(val);
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][5], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][6], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][7], style: TextStyle(color: Colors.white))),
      ]);
      vis[loc]++;
    }
    for (int i = 0; i < _counter; ++i) _data[i][0] = artime[i];
  }

  void _addrow() {
    setState(() {
      var t = _counter;
      _counter++;
      _data.add([0, 0, 0, 0, 0, 0, 0, 0]);
      _datas.add(['0', '0', '0', '0', '0', '0', '0', '0']);
      //_cardv.add([0, 0, 0, 0]);
      //_cardvs.add(['0', '0', '0', '0']);
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
        DataCell(TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          onChanged: (val) {
            _datas[t][2] = val;
            _data[t][2] = int.parse(val);
            setState(() {
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
            _datas[t][3] = val;
            _data[t][3] = int.parse(val);
            setState(() {
              _calculate();
            });
          },
        )),
        DataCell(Text(_datas[t][4], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][5], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][6], style: TextStyle(color: Colors.white))),
        DataCell(Text(_datas[t][7], style: TextStyle(color: Colors.white))),
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
          child: Column(
            children: <Widget>[
              Padding(
                child: Align(
                  child: Switch(
                      value: true,
                      onChanged: (t) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FCFS()),
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
                            label: Text('I/O BT',
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
                        DataColumn(
                            label: Text('RT',
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
                        'Delete Process',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _RemoveRow,
                    )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Gantt Chart',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (){
                        _Gant();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CARD(_cardvs,_readyq),
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
                        'Visulization',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _viz,
                    )),
                  ),
                ],
              ),
              Container(height:700),

            ],
          ),
        ));
  }
}