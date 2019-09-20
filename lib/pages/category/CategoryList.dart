import 'package:flutter/material.dart';
import '../../pluginPachaging/Screenutil.dart';
import 'package:dio/dio.dart';
import './data/CategoryListData.dart';
import '../../components/publicUrl.dart';
import '../../components/Loading.dart';

class CategoryList extends StatefulWidget {
  Map arguments;
  CategoryList({Key key, this.arguments}) : super(key: key);

  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var keyword;
  int currentIndex = 0;
  int page = 1;
  int pageSize = 8;
  int priceShow = 0;
  String sort = '';
  List goodsList = [];
  var flag = true;
  var dataLength = true;
  var hasData = true;
  List _subHeaderData = [
    {
      "id": 0,
      "title": "综合",
      "fileds": "all",
      "sort": -1,
    },
    {
      "id": 1,
      "title": "销量",
      "fileds": "salecount",
      "sort": -1,
    },
    {
      "id": 2,
      "title": "价格",
      "fileds": "price",
      "sort": -1,
    },
    {
      "id": 3,
      "title": "筛选",
      "fileds": "all",
      "sort": -1,
    },
  ];
  ScrollController _scrollController = ScrollController();
  // 输入框的值
  var _initTextFiledController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initTextFiledController.text=widget.arguments['keywords']==null?"":widget.arguments['keywords'];
    this._getCategoryList();
    _scrollController.addListener(() {
      _scrollController.position.pixels;
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this.dataLength) {
          this._getCategoryList();
        }
      }
    });
  }

  _getCategoryList() async {
    this.flag = false;
    var api;
    if (widget.arguments['cid'] == null) {
      api =
          "http://jd.itying.com/api/plist?&page=${this.page}&pageSize=${this.pageSize}&sort=${this.sort}&search=${_initTextFiledController.text}";
    } else {
      api =
          "http://jd.itying.com/api/plist?cid=${widget.arguments['cid']}&page=${this.page}&pageSize=${this.pageSize}&sort=${this.sort}";
    }
    var result = await Dio().get(api);

    var list = CategoryListData.fromJson(result.data);
    //判断搜索有没有数据
    if(list.result.length==0&&this.page==1){
      setState(() {
        this.hasData=false;
      });
        
    }else{
       setState(() {
        this.hasData=true;
      });
    }
    //判断最后一页有没有数据
    if (list.result.length < this.pageSize) {
      setState(() {
        this.goodsList.addAll(list.result);
        this.flag = true;
        this.dataLength = false;
      });
    } else {
      setState(() {
        this.goodsList.addAll(list.result);
        this.flag = true;
        this.page++;
      });
    }
  }

  Widget _CategoryListbottom(index) {
    if (this.dataLength) {
      return (index == this.goodsList.length - 1) ? LoadingWidget() : Text('');
    } else {
      return (index == this.goodsList.length - 1)
          ? Text(
              '我们是有底线的',
              style: TextStyle(color: Colors.grey),
            )
          : Text('');
    }
  }

  Widget _categoryList() {
    if (this.goodsList.length > 0) {
      return Container(
        width: Screenutil.width(750),
        margin: EdgeInsets.only(top: Screenutil.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: this.goodsList.length,
          itemBuilder: (context, index) {
            String pic = this.goodsList[index].pic;
            return GestureDetector(
            onTap:(){
              Navigator.pushNamed(context, '/goodsDetail',arguments: {
                "goodId":'11111'
              });
            },
            child:Container(
              width: Screenutil.width(750),
              child:  Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Container(
                    width: Screenutil.width(180),
                    height: Screenutil.height(180),
                    margin: EdgeInsets.only(bottom: Screenutil.height(20)),
                    child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                            "${PageUrl.jdUrl + pic.replaceAll('\\', '/')}",
                            fit: BoxFit.cover)),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: Screenutil.height(20)),
                        height: Screenutil.height(180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${this.goodsList[index].title}",
                              style: TextStyle(fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: Screenutil.width(20)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("4g"),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("4g"),
                                ),
                              ],
                            ),
                            Text("￥${this.goodsList[index].price}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16))
                          ],
                        ),
                      )),
                ]),
                Divider(height: 20),
                _CategoryListbottom(index)
              ],
              ),
            )
            );
          },
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  //头部Icons
  Widget _showIcons(int id) {
    if (id == 2) {
      if (this.priceShow == 1) {
        return Icon(Icons.keyboard_arrow_up, size: 10);
      }
      if (this.priceShow == 2) {
        return Icon(Icons.keyboard_arrow_down, size: 10);
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.keyboard_arrow_up, size: 10),
          Icon(Icons.keyboard_arrow_down, size: 10)
        ],
      );
    }
    if (id == 0) {
      return Icon(Icons.keyboard_arrow_down, size: 10);
    }
    return Text('');
  }
  //搜索判断
  _setHeader(id){
    if (id == 3) {
      setState(() {
        currentIndex = id;
        this.priceShow = 0;
      });
    } else {
      setState(() {
        currentIndex = id;
        this.priceShow = id != 2
            ? 0
            : this.priceShow == 0
                ? 1
                : this.priceShow == 1
                    ? 2
                    : this.priceShow == 2 ? 1 : 0;
        this.sort =
            "${this._subHeaderData[id]["fileds"]}_${this._subHeaderData[id]["sort"]}";
        this._subHeaderData[id]["sort"] =
            this._subHeaderData[id]["sort"] * -1;
        this.flag = true;
        this.dataLength = true;
        this.page = 0;
        this.goodsList = [];
        _scrollController.jumpTo(0);
        this._getCategoryList();
      });
    }
  }
  //头部导航
  Widget _topList() {
    return Positioned(
        top: 0,
        height: Screenutil.height(80),
        width: Screenutil.width(750),
        child: Container(
          width: Screenutil.width(750),
          height: Screenutil.height(80),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
              children: this._subHeaderData.map((value) {
            return Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  this._setHeader(value['id']);
                  
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, Screenutil.height(16), 0, Screenutil.height(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${value['title']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: currentIndex == value['id']
                                  ? Colors.red
                                  : Colors.black),
                        ),
                        this._showIcons(value['id'])
                      ],
                    )),
              ),
            );
          }).toList()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Screenutil.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: Screenutil.height(58),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromRGBO(235, 235, 235, 0.9),
            ),
            child: TextField(
              controller: _initTextFiledController,
              onChanged: (value) {
                setState(() {
                  this._initTextFiledController.text = value;
                });
              },
              // maxLines: 20,
              cursorColor: Colors.grey,
              autofocus: false,
              decoration: InputDecoration(
                  // hintText: '请输入搜索内容',
                  contentPadding: EdgeInsets.all(Screenutil.width(10)),
                  prefixIcon: InkWell(
                    child: Icon(Icons.search,
                        size: 18, color: Color.fromRGBO(133, 133, 133, 0.9)),
                    onTap: () {},
                  ),
                  suffixIcon: InkWell(
                    child: Icon(Icons.photo_camera,
                        size: 18, color: Color.fromRGBO(133, 133, 133, 0.9)),
                    onTap: () {},
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
            ),
          ),
          elevation: 0,
          actions: <Widget>[
            InkWell(
              child: Container(
                margin: EdgeInsets.only(right: Screenutil.width(20)),
                alignment: Alignment.center,
                child: Text(
                  '搜索',
                  style: TextStyle(color: Color.fromRGBO(129, 132, 139, 1)),
                ),
              ),
              onTap: () {
                _setHeader(1);
              },
            )
          ],
        ),
        body:this.hasData? Stack(
          children: <Widget>[_topList(), _categoryList()],
        ):Center(
          child: Text('没有搜到您要的数据'),
        ),
        endDrawer: Container(
          color: Colors.white,
          width: 400,
          height: double.infinity,
          child: Text('11111111'),
        ));
  }
}
