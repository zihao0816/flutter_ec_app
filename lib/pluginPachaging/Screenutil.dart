import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screenutil{
  static init(context){
    return ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }
  static height(double value){
    return ScreenUtil.getInstance().setHeight(value);
  }
  static width(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }
  static screenHeight(){
    return ScreenUtil.screenHeightDp;
  }
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }
   static size(double value){
    return ScreenUtil.getInstance().setSp(value) ;
  }
}