import 'package:flutter/material.dart';
import '../../../pluginPachaging/Screenutil.dart';
import 'package:dio/dio.dart';
import '../data/CategoryData.dart';
import './RightCategory.dart';

class LeftCategory extends StatefulWidget {
  LeftCategory({Key key}) : super(key: key);

  _LeftCategoryState createState() => _LeftCategoryState();
}

class _LeftCategoryState extends State<LeftCategory> {
  var leftWidth = Screenutil.getScreenWidth() / 4;
  List leftList = [];
  int num = 0;
  @override
  void initState() {
    super.initState();
    this._getCategoryData();
  }

  _getCategoryData() async {
    var api = "http://jd.itying.com/api/pcate";
    var result = await Dio().get(api);
    var list = CategoryData.fromJson(result.data);
    this.setState(() {
      this.leftList = list.result;
    });
    RightCategoryState().getCategoryDatas(list.result[0].sId);
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
                     RightCategoryState().getCategoryDatas(this.leftList[index].sId);
                   
                     
                      },
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: this.num == index
                                ? Colors.white
                                : Color.fromRGBO(240, 246, 246, 0.9),
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

  @override
  Widget build(BuildContext context) {
    return _leftCategory();
  }
}
