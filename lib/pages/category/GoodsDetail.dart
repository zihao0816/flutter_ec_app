import 'package:flutter/material.dart';
import '../../pluginPachaging/Screenutil.dart';
import './goods/Detail.dart';
import './goods/Evaluate.dart';
import './goods/Good.dart';
class GoodsDetail extends StatefulWidget {
  Map arguments;
  GoodsDetail({Key key,this.arguments}) : super(key: key);
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child:  Scaffold(
        appBar: AppBar(
          title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width:Screenutil.width(400),
                child:TabBar(
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                tabs:<Widget>[
                  Tab(child:Text('商品')),
                  Tab(child:Text('详情')),
                  Tab(child:Text('评价')),
                ]
              ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              splashColor:Colors.white,
              highlightColor:Colors.white,
              onPressed: (){
                showMenu(
                  context:context,
                  position:RelativeRect.fromLTRB(Screenutil.width(600), Screenutil.height(130),Screenutil.width(10) , 0),
                  items:[
                     PopupMenuItem(
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.message),
                            Text('消息')
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.home),
                            Text('首页')
                          ],
                        ),
                      ),
                    ),
                  ]
                );
              },
              icon: Icon(Icons.more_horiz),
            )
          ],
        ),
        body:Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                GoodPage(),
                DetailPage(),
                EvaluatePage()
              ],
            ),
            Positioned(
              width: Screenutil.width(750),
              height: Screenutil.height(80),
              bottom:0,
              child: Container(
                decoration: BoxDecoration(
                  color:Colors.white,
                  border: Border(
                    top:BorderSide(
                      width:1,
                      color: Colors.blue
                    )
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                     GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.only(right: Screenutil.width(20)),
                        height: double.infinity,
                        alignment:Alignment.center,
                        child: Column(
                        children: <Widget>[
                          Icon(Icons.home,size: 16),
                          Text(
                          '客服',
                          style: TextStyle(
                            fontSize: Screenutil.size(20),
                          ),
                        ),
                        ],
                       ) ,
                      )
                    ),
                      GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.only(right: Screenutil.width(20)),
                        child: Column(
                        children: <Widget>[
                          Icon(Icons.message,size: 16),
                          Text(
                          '消息',
                          style: TextStyle(
                            fontSize: Screenutil.size(20),
                          ),
                        ),
                        ],
                       ) ,
                      )
                    ),
                     GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.only(right: Screenutil.width(20)),
                        child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart,size: 16),
                          Text(
                          '购物车',
                          style: TextStyle(
                            fontSize: Screenutil.size(20),
                          ),
                        ),
                        ],
                       ) ,
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right:Screenutil.width(20)),
                        height: Screenutil.height(70),
                        alignment: Alignment.center,
                        // padding: EdgeInsets.fromLTRB(Screenutil.width(10), 0, Screenutil.width(10), 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red,
                        ),
                        child: Text(
                          '加入购物车',
                          style: TextStyle(
                            fontSize: Screenutil.size(20),
                            color:Colors.white
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right:Screenutil.width(20)),
                        // padding: EdgeInsets.fromLTRB(Screenutil.width(10), 0, Screenutil.width(10), 0),
                        height: Screenutil.height(70),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.yellow,
                        ),
                        child: Text(
                          '立即购买',
                          style: TextStyle(
                            fontSize: Screenutil.size(20),
                            color:Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
    ),
    );
  }
}