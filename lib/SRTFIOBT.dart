import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './SRTF.dart';
import './Card.dart';

//FCFS page stateful class
class SRTFIOBT extends StatefulWidget {
  @override
  _SRTFIOBTState createState() => _SRTFIOBTState();
}

class _SRTFIOBTState extends State<SRTFIOBT> {
  var _counter = 0;

  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];

  void _run(){
    _cardv.clear();
    _cardvs.clear();
    _cardv.add([0, 0, 0, 0]);
    _cardvs.add(['0', '0', '0', '0']);
    int cal = 0, st = 0,_tt=0;
    List<int> vis, artime, tbt, bt1, bt2;
    vis = new List<int>.filled(_counter, 0);
    artime = new List<int>.filled(_counter, 0);
    tbt = new List<int>.filled(_counter, 0);
    bt1 = new List<int>.filled(_counter, 0);
    bt2 = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      artime[i] = _data[i][0];
      tbt[i] = _data[i][1] + _data[i][3];
      bt1[i] = _data[i][1];
      bt2[i] = _data[i][3];
    }

    while (cal != 2 * _counter) {
      var mn = 100,
          loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (tbt[i] < mn && (vis[i] == 0 || vis[i] == 1) && st >= _data[i][0]) {
          mn = tbt[i];
          loc = i;
          f = false;
        }
      }
      if (f) {
        st++;
        continue;
      }
      //print(loc);
      //print(st);
      //print('----');
      _data[loc][7] = min(_data[loc][7], st);
      //print(loc);
      if (vis[loc] == 0) {
        if (_data[loc][1] > 0) {
          if(_tt==0 && _cardv[_tt][0]==0 && _cardv[_tt][1]==0 && _cardv[_tt][2]==0){
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st+1;
          }
          else if(_cardv[_tt][0]==loc && _cardv[_tt][2]==st){
            _cardv[_tt][2]++;
          }
          else{
            _tt++;
            _cardv.add([0, 0, 0, 0]);
            _cardvs.add(['0', '0', '0', '0']);
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st+1;
          }
          st++;
          _data[loc][1]--;
          tbt[loc]--;
        }
        if (_data[loc][1] == 0) {
          if(_tt==0 && _cardv[_tt][0]==0 && _cardv[_tt][1]==0 && _cardv[_tt][2]==0){
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st+1;
            _cardv[_tt][3]=2;
          }
          else if(_cardv[_tt][0]==loc){
            _cardv[_tt][2]++;
            _cardv[_tt][3]=2;
          }
          else{
            _tt++;
            _cardv.add([0, 0, 0, 0]);
            _cardvs.add(['0', '0', '0', '0']);
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st+1;
            _cardv[_tt][3]=2;
          }
          _data[loc][0] = st + _data[loc][2];
          vis[loc]++;
          cal++;
        }
      }
      else {
        if (_data[loc][3] > 0) {
          if(_tt==0 && _cardv[_tt][0]==0 && _cardv[_tt][1]==0 && _cardv[_tt][2]==0){
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st+1;
          }
          else if(_cardv[_tt][0]==loc && _cardv[_tt][2]==st){
            _cardv[_tt][2]++;
          }
          else{
            _tt++;
            _cardv.add([0, 0, 0, 0]);
            _cardvs.add(['0', '0', '0', '0']);
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st+1;
          }
          st++;
          _data[loc][3]--;
          tbt[loc]--;

        }
        if (_data[loc][3] == 0) {
          if(_tt==0 && _cardv[_tt][0]==0 && _cardv[_tt][1]==0 && _cardv[_tt][2]==0){
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st;
            _cardv[_tt][3]=1;
          }
          else if(_cardv[_tt][0]==loc){
            //_cardv[_tt][2]++;
            _cardv[_tt][3]=1;
          }
          else{
            _tt++;
            _cardv.add([0, 0, 0, 0]);
            _cardvs.add(['0', '0', '0', '0']);
            _cardv[_tt][0]=loc;
            _cardv[_tt][1]=st;
            _cardv[_tt][2]=st;
            _cardv[_tt][3]=1;
          }
          vis[loc]++;
          cal++;
          _data[loc][4] = st;
          _data[loc][5] = _data[loc][4] - artime[loc];
          _data[loc][6] = _data[loc][5] - bt1[loc] - bt2[loc];
        }
      }
      for (int i = 0; i < 8; ++i) _datas[loc][i] = _data[loc][i].toString();
      for (int i=0;i<4;++i) _cardvs[_tt][i]=_cardv[_tt][i].toString();
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][0] = artime[i];
      _data[i][1] = bt1[i];
      _data[i][3] = bt2[i];
    }

  }

  void _calculate() {
    int cal = 0, st = 0;
    List<int> vis, artime, tbt, bt1, bt2;
    vis = new List<int>.filled(_counter, 0);
    artime = new List<int>.filled(_counter, 0);
    tbt = new List<int>.filled(_counter, 0);
    bt1 = new List<int>.filled(_counter, 0);
    bt2 = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) {
      artime[i] = _data[i][0];
      tbt[i] = _data[i][1] + _data[i][3];
      bt1[i] = _data[i][1];
      bt2[i] = _data[i][3];
    }
    while (cal != 2 * _counter) {
      var mn = 100, loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (tbt[i] < mn && (vis[i] == 0 || vis[i] == 1) && st >= _data[i][0]) {
          mn = tbt[i];
          loc = i;
          f = false;
        }
      }
      if (f) {
        st++;
        continue;
      }
      //print(loc);
      //print(st);
      //print('----');
      _data[loc][7] = min(_data[loc][7], st);
      //print(loc);
      if (vis[loc] == 0) {
        if (_data[loc][1] > 0) {
          st++;
          _data[loc][1]--;
          tbt[loc]--;
        }
        if (_data[loc][1] == 0) {
          _data[loc][0] = st + _data[loc][2];
          vis[loc]++;
          cal++;
        }
      }
      else {
        if (_data[loc][3] > 0) {
          st++;
          _data[loc][3]--;
          tbt[loc]--;
        }
        if (_data[loc][3] == 0) {
          vis[loc]++;
          cal++;
          _data[loc][4] = st;
          _data[loc][5] = _data[loc][4] - artime[loc];
          _data[loc][6] = _data[loc][5] - bt1[loc] - bt2[loc];
        }
      }
      for (int i = 0; i < 8; ++i) _datas[loc][i] = _data[loc][i].toString();
      int t = loc;
      _rowList[loc] = DataRow(cells: <DataCell>[
        DataCell(
            Text('P' + t.toString(), style: TextStyle(color: Colors.white))),
        DataCell(TextField(
          //expands: true,
          // inputFormatters: [
          //   LengthLimitingTextInputFormatter(2),
          // ],
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
    }
    for (int i = 0; i < _counter; ++i) {
      _data[i][0] = artime[i];
      _data[i][1] = bt1[i];
      _data[i][3] = bt2[i];
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
            'SRTF',
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
                      value: true,
                      onChanged: (t) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SRTF()),
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