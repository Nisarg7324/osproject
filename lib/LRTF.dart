import 'package:flutter/material.dart';
import 'dart:math';

import './LRTFIOBT.dart';
import './Card.dart';
import './View.dart';

//LRTF page stateful class
class LRTF extends StatefulWidget {
  @override
  _LRTFState createState() => _LRTFState();
}

class _LRTFState extends State<LRTF> {
  var _counter = 0;

  List<DataRow> _rowList = [];
  List<List<int>> _data = [];
  List<List<String>> _datas = [];
  List<List<int>> _cardv = [];
  List<List<String>> _cardvs = [];
  List<List<bool>> _readyq = [];
  List<String> _Na = [], _Re = [], _Ru = [], _Te = [];
  List<List<Widget>> _disdata = [], _disNum = [];

  void _viz(){
    int fct = 0;
    for (int i = 0; i < _counter; ++i) {
      fct = max(fct, _data[i][2]);
    }
    List<int> _ddata;
    _ddata = new List<int>.filled(fct + 1, -1);

    int cal = 0, st = 0;
    List<bool> vis;
    List<int> val;
    vis = new List<bool>.filled(_counter, false);
    val = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) val[i] = _data[i][1];
    while (cal != _counter) {
      var mx = -1, loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][1] > mx && !vis[i] && st >= _data[i][0]) {
          mx = _data[i][1];
          loc = i;
          f = false;
        }
      }
      if (f) {
        st++;
        continue;
      }
      if (_data[loc][1] > 0) {
        st++;
        _ddata[st] = loc;
        _data[loc][1]--;
      }
      if (_data[loc][1] == 0) {
        vis[loc] = true;
        cal++;
      }
      _data[loc][2] = st;
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - val[loc];
    }
    for (int i = 0; i < _counter; ++i) _data[i][1] = val[i];



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

    view.TakeData('LRTF', _Na, _Re, _Ru, _Te, fct, _disdata, _disNum);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view()),
    );
  }

  void _Gant(){
    _cardv.clear();
    _cardvs.clear();
    _readyq.clear();
    int cal = 0, st = 0,_tt=0;
    _cardv.add([0,0,0,0]);
    _cardvs.add(['0','0', '0','0']);
    List<bool> vis;
    List<int> val;
    vis = new List<bool>.filled(_counter, false);
    val = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) val[i] = _data[i][1];
    while (cal != _counter) {
      _readyq.add(List.filled(_counter, false));
      var mx = -1,
          loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][1] > mx && !vis[i] && st >= _data[i][0]) {
          mx = _data[i][1];
          loc = i;
          f = false;
        }
        /*
        if(!vis[i] && st >= _data[i][0]){
          _readyq[_tt][i]=true;
        }*/
      }
      if (f) {
        st++;
        //_readyq.removeLast();
        continue;
      }
      if (_data[loc][1] > 0) {
        if(_tt==0 && _cardv[_tt][0]==0 && _cardv[_tt][1]==0 && _cardv[_tt][2]==0){
          _cardv[_tt][0]=loc;
          _cardv[_tt][1]=st;
          _cardv[_tt][2]=st+1;
          for (var i = 0; i < _counter; ++i) {
            if(!vis[i] && st >= _data[i][0]){
              _readyq[_tt][i]=true;
            }
          }
        }
        else if(_cardv[_tt][0]==loc ){
          _cardv[_tt][2]++;
        }
        else{
          _tt++;
          _cardv.add([0,0,0,0]);
          _cardvs.add(['0','0', '0','0']);
          _cardv[_tt][0]=loc;
          _cardv[_tt][1]=st;
          _cardv[_tt][2]=st+1;
          for (var i = 0; i < _counter; ++i) {
            if(!vis[i] && st >= _data[i][0]){
              _readyq[_tt][i]=true;
            }
          }
        }
        st++;
        _data[loc][1]--;
      }
      if (_data[loc][1] == 0) {
        vis[loc] = true;
        _cardv[_tt][3]=1;
        cal++;
      }
      _data[loc][2] = st;
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - val[loc];
      for (int i = 0; i < 5; ++i) _datas[loc][i] = _data[loc][i].toString();
      for (int i = 0; i < 4; ++i) _cardvs[_tt][i] = _cardv[_tt][i].toString();
    }
  }

  void _calculate() {
    int cal = 0, st = 0;
    List<bool> vis;
    List<int> val;
    vis = new List<bool>.filled(_counter, false);
    val = new List<int>.filled(_counter, 0);
    for (int i = 0; i < _counter; ++i) val[i] = _data[i][1];
    while (cal != _counter) {
      var mx = -1, loc = 0;
      bool f = true;
      for (var i = 0; i < _counter; ++i) {
        if (_data[i][1] > mx && !vis[i] && st >= _data[i][0]) {
          mx = _data[i][1];
          loc = i;
          f = false;
        }
      }
      if (f) {
        st++;
        continue;
      }
      if (_data[loc][1] > 0) {
        st++;
        _data[loc][1]--;
      }
      if (_data[loc][1] == 0) {
        vis[loc] = true;
        cal++;
      }
      _data[loc][2] = st;
      _data[loc][3] = _data[loc][2] - _data[loc][0];
      _data[loc][4] = _data[loc][3] - val[loc];
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
    for (int i = 0; i < _counter; ++i) _data[i][1] = val[i];
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
          title: Text('LRTF',style: TextStyle(fontFamily:'Pacifico'),),
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
                          MaterialPageRoute(builder: (context) => LRTFIOBT()),
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
        )
    );
  }
}