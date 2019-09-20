import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../data/MainImage.dart';
import '../../../pluginPachaging/Screenutil.dart';
import '../../../components/publicUrl.dart';

class MainImage extends StatefulWidget {
  MainImage({Key key}) : super(key: key);

  _MainImageState createState() => _MainImageState();
}

class _MainImageState extends State<MainImage> {
  List mainImageList = [];
  @override
  void initState() {
    super.initState();
    this._getMainImageData();
  }

  _getMainImageData() async {
    var api =
        'https://easymock.zikuinfo.com/mock/5d6f48e9324c0d00188046a2/api/recommond';
    var result = await Dio().get(api);
    var list = MainImageData.fromJson(result.data);
    this.setState(() {
      this.mainImageList = list.result;
    });
  }

  Widget itemProdect() {
    var screenWidths =
        (Screenutil.getScreenWidth() - Screenutil.width(64.0)) / 2;
    return Container(
      padding: EdgeInsets.fromLTRB(
          Screenutil.width(20.0),
          Screenutil.height(20.0),
          Screenutil.width(20.0),
          Screenutil.height(20.0)),
      child: Wrap(
          runSpacing: Screenutil.width(20.0),
          spacing: Screenutil.height(20.0),
          children: this.mainImageList.map((value) {
            String sPic = value.sPic;
            sPic = PageUrl.jdUrl + sPic.replaceAll('\\', '/');
            return Container(
              width: screenWidths,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      width: Screenutil.width(1.0))),
              padding: EdgeInsets.fromLTRB(
                  Screenutil.width(20.0),
                  Screenutil.height(20.0),
                  Screenutil.width(20.0),
                  Screenutil.height(20.0)),
              child: Column(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                            "${sPic}",
                            fit: BoxFit.cover),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: Screenutil.height(20.0)),
                    child: Text(
                      "${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Screenutil.height(20.0)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text( "¥${value.price}",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("¥${value.oldPrice}",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemProdect();
  }
}
