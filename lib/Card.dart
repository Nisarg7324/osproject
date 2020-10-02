import 'package:flutter/material.dart';

class CARD extends StatefulWidget{
  List ll=[];
  CARD(List _cardvs)
  {
    ll=_cardvs;
  }




  @override
  State<StatefulWidget> createState() {
    return CARDstate(ll);
  }

}

class CARDstate extends State{
  List ls=[];
  CARDstate(ll)
  {
    ls=ll;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VISulizaTiON'
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            for(var i=0;i<ls.length;i++) Vcard(i,ls)
            //Vcard(0,ls),
            //Vcard(1,ls),
          ],
        ),
      ),
    );
  }

}

class Vcard extends StatelessWidget{
  var index;
  List lls;
  Vcard(int i, List ls){
    index=i;
    lls=ls;
  }

  isCompleted(){
    if(lls[index][3]=='1'){
      return Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              //height: 100,
              child: Text('Process ' + (index+1).toString() + ' Is Finished',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green
                ),
              ),
            ),
          ),
        ],
      );

  }
    else if(lls[index][3]=='2'){
      return Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              //height: 100,
              child: Text('Process ' + (index+1).toString() + ' Will go for IO Burst Time',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green
                ),
              ),
            ),
          ),
        ],
      );
    }
    else{
      return Container(
        child: Text(' '),
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          height: 150,

          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          //height: 100,
                          child: Text('Process:' + lls[index][0] ,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          //height: 50,
                          child: Text('Start Time: ' + lls[index][1],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          //height: 50,
                          child: Text('End Time: ' + lls[index][2],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isCompleted(),


                ],
              )
          ),

        ),
      ),
    );
  }

}