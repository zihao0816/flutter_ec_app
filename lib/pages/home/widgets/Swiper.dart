import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../pluginPachaging/Screenutil.dart';
import '../data/Swiper.dart';
import '../../../components/publicUrl.dart';


class SwiperPage extends StatefulWidget {
  SwiperPage({Key key}) : super(key: key);

  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  List swiperList=[] ;
  @override
  void initState() { 
    super.initState();
    this._getSwiperData();
  }
  _getSwiperData() async {
    var api='https://easymock.zikuinfo.com/mock/5d6f48e9324c0d00188046a2/api/focus';
    var result = await Dio().get(api);
    var list = SwiperData.fromJson(result.data);
    this.setState((){
      this.swiperList = list.result;
    });
  }
  Widget swiperWidget(){
     if(this.swiperList.length>0){
        return Container(
        height:160.0,
        width:double.infinity ,
        margin:EdgeInsets.only(bottom:Screenutil.width(20.0) ),
        child: AspectRatio(
          aspectRatio: 2/1,
          child: Swiper(
            itemBuilder: (BuildContext context,int index){
              var pic =this.swiperList[index].pic;
              return Image.network("${(PageUrl.jdUrl)+(pic.replaceAll('\\', '/'))}",fit: BoxFit.fill,);
            },
            itemCount: this.swiperList.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        )
      );
    }else{
        return Text('加载中...');
    }
  }
  @override
  Widget build(BuildContext context) {
    return swiperWidget();
  }
}