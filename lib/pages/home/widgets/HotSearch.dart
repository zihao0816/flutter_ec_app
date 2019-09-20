import 'package:flutter/material.dart';
import '../../../pluginPachaging/Screenutil.dart';
import '../../../components/StorageData.dart';

class HotSearch extends StatefulWidget {
  HotSearch({Key key}) : super(key: key);

  _HotSearchState createState() => _HotSearchState();
}

class _HotSearchState extends State<HotSearch> {
  var buttonShow = false;
  var _index ;//数组下标
  List _historyData = [];
  @override
  void initState() { 
    super.initState();
    this.initGetData();
  }
  initGetData() async{
    List tempList = await StorageData.getData();
    setState(() {
      this._historyData= tempList;
    });
  }
  Widget _history() {
    return Wrap(
      children:this._historyData.length==0? <Widget>[Text('没有历史数据')]:this._historyData.asMap().keys.map((index){
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.9),
                borderRadius: BorderRadius.circular(15)),
            child: this.buttonShow&&this._index == index
                ? Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Text("${this._historyData[index]}"),
                      SizedBox(width:2),
                      Container(
                        margin:EdgeInsets.only(top:1),
                        alignment: Alignment.centerRight,
                        width:14.0,
                        child:Icon(Icons.clear, size: 10),
                      )
                    ],
                  )
                : Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child:Text("${this._historyData[index]}") ,
                )
          ),
          onTap: () async{
            if (this.buttonShow == true&&this._index == index) {
              await StorageData.removeData(_historyData[index]);
              this.initGetData();
            } else {
              Navigator.pushReplacementNamed(context, '/categoryList',arguments: {
                  "keywords":_historyData[index]
                });
            }
          },
          onLongPress: () {
            setState(() {
              this._index = index;
              this.buttonShow = true;
            });
          },
        );
      }).toList()
      
    );
  }

  @override
  Widget build(BuildContext context) {
    Screenutil.init(context);
    return Container(
        padding: EdgeInsets.fromLTRB(Screenutil.width(20),
            Screenutil.height(20), 0, Screenutil.height(20)),
        child: ListView(
          children: <Widget>[
            Container(
              height: Screenutil.height(60),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('搜索历史',
                        style: TextStyle(
                            fontSize: Screenutil.size(30.0),
                            color: Colors.black)),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 16,
                            color: Color.fromRGBO(215, 215, 215, 1),
                          ),
                          onPressed: () async{
                            await StorageData.clearData();
                            this.initGetData();
                          },
                        ),
                      )),
                ],
              ),
            ),
            this._history(),
            Container(
              height: Screenutil.height(60),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('搜索发现',
                        style: TextStyle(
                            fontSize: Screenutil.size(30.0),
                            color: Colors.black)),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 16,
                            color: Color.fromRGBO(215, 215, 215, 1),
                          ),
                          onPressed: () {
                           
                          },
                        ),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: Screenutil.width(10)),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: Screenutil.width(30)),
                    child: FlatButton(
                      child: Text('男'),
                      color: Color.fromRGBO(235, 235, 235, 0.9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      textColor: Colors.black,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
