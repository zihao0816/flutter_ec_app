import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../pluginPachaging/Screenutil.dart';
import '../data/CategoryData.dart';
import '../../../components/publicUrl.dart';

class RightCategory extends StatefulWidget {
  RightCategory({Key key}) : super(key: key);
  RightCategoryState createState() => RightCategoryState();
}

class RightCategoryState extends State<RightCategory> {
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
  getCategoryDatas(pid) async {
    var api = "http://jd.itying.com/api/pcate?pid=${pid}";
    var result = await Dio().get(api);
    var list = CategoryData.fromJson(result.data);
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        this.rightList = list.result;
      });
    });
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
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Screenutil.width(20),
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  crossAxisSpacing: Screenutil.height(20)),
              itemBuilder: (context, index) {
                var pic = this.rightList[index].pic;
                return Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                          "${PageUrl.jdUrl + pic.replaceAll('\\', '/')}",
                          fit: BoxFit.cover),
                    ),
                    Container(
                      height: Screenutil.height(28),
                      child: Text("${this.rightList[index].title}"),
                    )
                  ],
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
    return _rightCategory();
  }
}
