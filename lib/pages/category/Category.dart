import 'package:flutter/material.dart';
import '../../pluginPachaging/Screenutil.dart';
import './data/CategoryData.dart';
import 'package:dio/dio.dart';
import '../../components/publicUrl.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);
  _CategoryPageState createState() => _CategoryPageState();
}
class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
   @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
   var leftWidth = Screenutil.getScreenWidth() / 4;
  List leftList = [];
   int num = 0;
    var rightItemWidth = (Screenutil.getScreenWidth() -
          Screenutil.getScreenWidth() / 4 -
          Screenutil.width(80)) /
      3;
  var rightItemHeight = (Screenutil.getScreenWidth() -
              Screenutil.getScreenWidth() / 4 -
              Screenutil.width(80)) /
          3 +
      Screenutil.height(28);
  List rightList = [];
   @override
   void initState() { 
     super.initState();
     _getCategoryData();
   }
   _getCategoryData() async {
    var api = "http://jd.itying.com/api/pcate";
    var result = await Dio().get(api);
    var list = CategoryData.fromJson(result.data);
    setState(() {
      this.leftList = list.result;
    });
    getRightCategoryDatas(list.result[0].sId);
  }
  //
  getRightCategoryDatas(pid) async {
    var api = "http://jd.itying.com/api/pcate?pid=${pid}";
    var result = await Dio().get(api);
    var list = CategoryData.fromJson(result.data);
      setState(() {
        this.rightList = list.result;
      });
  }
   Widget _leftCategory() {
    if (this.leftList.length > 0) {
      return Container(
          margin: EdgeInsets.only(top: Screenutil.height(10)),
          width: leftWidth,
          height: double.infinity,
          child: ListView.builder(
            itemCount: this.leftList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        this.setState(() {
                          this.num = index;
                        });
                     this.getRightCategoryDatas(this.leftList[index].sId);
                   
                     
                      },
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: this.num == index
                                ? Colors.white
                                : Color.fromRGBO(246, 246, 246, 0.9),
                          ),
                          padding: EdgeInsets.fromLTRB(0, Screenutil.height(20),
                              0, Screenutil.height(20)),
                          child: Text(
                            '${this.leftList[index].title}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: this.num == index ? 20 : 16,
                                color: this.num == index
                                    ? Color.fromRGBO(45, 45, 45, 1)
                                    : Color.fromRGBO(132, 132, 132, 1)),
                          ))),
                ],
              );
            },
          ));
    } else {
      return Container(
          margin: EdgeInsets.only(top: Screenutil.height(10)),
          width: leftWidth,
          height: double.infinity,
          child: Text('加载中'));
    }
  }
  Widget _rightCategory() {
    if (this.rightList.length > 0) {
      return Expanded(
          flex: 1,
          child: Container(
            // color: Color.fromRGBO(240, 246, 246, 0.9),
            margin: EdgeInsets.only(top: Screenutil.height(10)),
            padding: EdgeInsets.fromLTRB(
                Screenutil.width(20), 0, Screenutil.width(20), 0),
            child: GridView.builder(
              itemCount: this.rightList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Screenutil.width(20),
                  childAspectRatio: rightItemWidth / (rightItemHeight+Screenutil.height(10)),
                  crossAxisSpacing: Screenutil.height(20)),
              itemBuilder: (context, index) {
                var pic = this.rightList[index].pic;
                return InkWell(
                  onTap:(){
                    Navigator.pushNamed(context,'/categoryList',arguments: {
                      "cid":this.rightList[index].sId
                    });
                  } ,
                  child:Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                          "${PageUrl.jdUrl + pic.replaceAll('\\', '/')}",
                          fit: BoxFit.cover),
                    ),
                    Container(
                      height: Screenutil.height(28),
                      child: Text("${this.rightList[index].title}",style:TextStyle(fontSize: 12)),
                    )
                  ],
                ) ,
                );

              },
            ),
          ));
    } else {
      return  Text('11111');
    }
  }
  @override
  Widget build(BuildContext context) {
    Screenutil.init(context);
    return Row(
      children: <Widget>[_leftCategory(), _rightCategory()],
    );
  }

 
}
