import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './RR.dart';

//FCFS page stateful class
class RRIOBT extends StatefulWidget {
  @override
  _RRIOBTState createState() => _RRIOBTState();
}

class _RRIOBTState extends State<RRIOBT> {
  var _counter = 0;
  int TQ = 1;
  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];

  void _calculate() {
    int st = 0;
    List<int> RQ = [], bt, at;
    bt = new List<int>.filled(_counter, 0);
    at = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      bt[i] = _data[i][1];
      at[i] = _data[i][0];
    }
    int mn = 100;
    for (int i = 0; i < _counter; ++i) {
      if (mn > _data[i][0] && _data[i][1] > 0) {
        mn = _data[i][0];
      }
    }
    if (mn == 100) return;
    for (int i = 0; i < _counter; ++i) {
      if (_data[i][0] == mn) RQ.add(i);
    }
    int it = 0, et = 0;
    while (true) {
      bool flag = true;
      for (int i = 0; i < _counter; ++i) {
        if (_data[i][1] > 0) flag = false;
      }
      if (flag) break;
      if (it < RQ.length && _data[RQ[it]][1] <= 0) {
        it++;
        continue;
      }
      if (it < RQ.length) {
        if (_data[RQ[it]][1] >= TQ) {
          _data[RQ[it]][1] -= TQ;
          _data[RQ[it]][0] += TQ;
          for (int i = et + 1; i <= et + TQ; i++) {
            for (int j = 0; j < _counter; ++j) {
              if (_data[j][1] > 0 && _data[j][0] == i && RQ[it] != j) {
                RQ.add(j);
              }
            }
          }
          et += TQ;
          if (_data[RQ[it]][1] > 0) RQ.add(RQ[it]);
          it++;
        } else {
          int temp = min(_data[RQ[it]][1], TQ);
          _data[RQ[it]][1] -= temp;
          _data[RQ[it]][0] += temp;
          for (int i = et + 1; i <= et + temp; i++) {
            for (int j = 0; j < _counter; ++j) {
              if (_data[j][1] > 0 && _data[j][0] == i && RQ[it] != j) {
                RQ.add(j);
              }
            }
          }
          et += temp;
          if (_data[RQ[it]][1] > 0) RQ.add(RQ[it]);
          it++;
        }
      } else {
        mn = 100;
        for (int i = 0; i < _counter; ++i) {
          if (mn > _data[i][0] && _data[i][1] > 0) {
            mn = _data[i][0];
          }
        }
        for (int i = 0; i < _counter; ++i) {
          if (mn == _data[i][0]) RQ.add(i);
        }
      }
    }
    for (int i = 0; i < _counter; ++i) {
      int pp = bt[i];
      _data[i][1] = pp;
      pp = at[i];
      _data[i][0] = pp;
    }
    st = 0;
    for (int i in RQ) {
      if (_data[i][1] <= 0) continue;
      if (_data[i][1] <= TQ) {
        st = max(st, _data[i][0]) + min(TQ, _data[i][1]);
        _data[i][1] -= TQ;
        _data[i][2] = st;
        _data[i][3] = _data[i][2] - at[i];
        _data[i][4] = _data[i][3] - bt[i];
      } else {
        st += TQ;
        _data[i][1] -= TQ;
      }
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt[i];
      _data[i][0] = at[i];
    }
    for (int loc = 0; loc < _counter; ++loc) {
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
      _data.add([0, 0, 0, 0, 0, 0, 0, 0]);
      _datas.add(['0', '0', '0', '0', '0', '0', '0', '0']);
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
            'RR',
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
                  child: Text(
                    'I/O Device',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  alignment: Alignment.topRight,
                ),
                padding: EdgeInsets.only(right: 30),
              ),
              Padding(
                child: Align(
                  child: Switch(
                      value: true,
                      onChanged: (t) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RR()),
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
              TextField(
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                onChanged: (val) {
                  TQ = int.parse(val);
                  setState(() {
                    _calculate();
                  });
                },
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
                      onPressed: _RemoveRow,
                    )),
                  )
                ],
              ),
              Container(height: 700),
            ],
          ),
        ));
  }
}
