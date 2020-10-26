import 'dart:math';
import 'package:flutter/material.dart';
import './RRIOBT.dart';
import './view.dart';

//FCFS page stateful class
class RR extends StatefulWidget {
  @override
  _RRState createState() => _RRState();
}

class _RRState extends State<RR> {
  var _counter = 0;
  int TQ = 1;
  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<String> _Na = [], _Re = [], _Ru = [], _Te = [];
  List<List<Widget>> _disdata = [], _disNum = [];

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
        st = max(st, _data[i][0]) + TQ;
        _data[i][1] -= TQ;
        _data[i][2] = st;
        _data[i][3] = _data[i][2] - at[i];
        _data[i][4] = _data[i][3] - bt[i];
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
      _data.add([0, 0, 0, 0, 0]);
      _datas.add(['0', '0', '0', '0', '0']);
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

  void _run() {
    int fct = 0;
    for (int i = 0; i < _counter; ++i) {
      fct = max(fct, _data[i][2]);
    }
    List<int> _ddata;
    _ddata = new List<int>.filled(fct + 1, -1);

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
        st += max(st, _data[i][0]) + TQ;
        _data[i][1] -= TQ;
      }
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][1] = bt[i];
      _data[i][0] = at[i];
    }

    List<int> _Running;
    _Running = new List<int>.filled(fct + 1, -1);
    for (int i = 0; i < fct; ++i) {
      if (_ddata[i] == _ddata[i + 1]) {
        _Running[i] = _ddata[i];
      }
    }
    _disdata.clear();
    _disdata.add([]);
    _disNum.clear();
    _disNum.add([]);
    for (int i = 1; i <= fct; ++i) {
      _disdata.add([]);
      _disNum.add(
        [
          Container(
            height: 30,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ],
      );
      for (int j = 1; j <= i; ++j) {
        String temp = 'P' + _ddata[j].toString();
        if (_ddata[j] == -1) temp = ' ';
        if (j + 1 <= i && _ddata[j] == _ddata[j + 1]) continue;
        _disNum[i].add(
          Container(height: 70),
        );
        _disNum[i].add(
          Container(
            height: 30,
            child: Text(
              j.toString(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        );
        if (j == i && j + 1 <= fct && _ddata[j] == _ddata[j + 1]) {
          _disdata[i].add(
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.red),
                  right: BorderSide(color: Colors.red),
                  top: BorderSide(color: Colors.red),
                ),
              ),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  temp,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          );
          continue;
        }
        _disdata[i].add(
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                temp,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        );
      }
    }
    _Na.clear();
    _Re.clear();
    _Ru.clear();
    _Te.clear();
    for (int i = 0; i <= fct; ++i) {
      String tempNa = '', tempRe = '', tempTe = '', tempRu = '';
      for (int j = 0; j < _counter; ++j) {
        if (_data[j][0] > i) {
          if (tempNa.isEmpty)
            tempNa += 'P' + j.toString();
          else
            tempNa += ', P' + j.toString();
        } else if (_data[j][2] <= i) {
          if (tempTe.isEmpty)
            tempTe += 'P' + j.toString();
          else
            tempTe += ', P' + j.toString();
        } else if (_Running[i] == j) {
          tempRu += 'P' + j.toString();
        } else {
          if (tempRe.isEmpty)
            tempRe += 'P' + j.toString();
          else
            tempRe += ', P' + j.toString();
        }
      }
      _Na.add(tempNa);
      _Te.add(tempTe);
      _Re.add(tempRe);
      _Ru.add(tempRu);
    }

    view.TakeData('RR', _Na, _Re, _Ru, _Te, fct, _disdata, _disNum);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view()),
    );
  }

  var fo = true;
  @override
  Widget build(BuildContext context) {
    if (fo) {
      _addrow();
      fo = false;
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
                      value: false,
                      onChanged: (t) {
                        Navigator.pop(context);
                        // Navigator.of(context).push(FCFSIOBT());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RRIOBT()),
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
                      onPressed: _run,
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