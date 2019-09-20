import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../pluginPachaging/Screenutil.dart';
import '../data/ImageText.dart';
import '../../../components/publicUrl.dart';

class ImageText extends StatefulWidget {
  ImageText({Key key}) : super(key: key);
  _ImageTextState createState() => _ImageTextState();
}

class _ImageTextState extends State<ImageText> {
   List imageList=[] ;
  @override
  void initState() { 
    super.initState();
    this._getimageText();
  }
  _getimageText() async {
    var api='https://easymock.zikuinfo.com/mock/5d6f48e9324c0d00188046a2/api/love';
    var results = await Dio().get(api);
    var lists = ImageData.fromJson(results.data);
    this.setState((){
      this.imageList = lists.result;
    });
  }
  Widget imageTexts(){
    if(this.imageList.length>0){
     return Container(
      height:Screenutil.height(160.0),
      margin:EdgeInsets.only(left:Screenutil.width(20.0)),
      child:ListView.builder(
        scrollDirection:Axis.horizontal ,
        itemCount: this.imageList.length,
        itemBuilder:(context,index){
          return Column(
            children: <Widget>[
              Container(
                width:Screenutil.width(100.0),
                height:Screenutil.height(100.0),
                margin:EdgeInsets.only(right:Screenutil.width(20.0)),
                child: Image.network("${PageUrl.jdUrl+this.imageList[index].pic.replaceAll('\\', '/')}",fit:BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.only(top: Screenutil.height(16.0)),
                child:Text(
                  "￥${this.imageList[index].price}",
                  style:TextStyle(
                    color: Colors.red
                  )
                )
              )
            ],
          );
        } ,
      )
    );
    }else{
      return Container(
        height:Screenutil.height(160.0),
        child: Text('加载中'),
      );
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return imageTexts();
  }
}