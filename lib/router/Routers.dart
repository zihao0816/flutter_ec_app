import 'package:flutter/material.dart';
import '../pages/tabs/Tab.dart';
import '../pages/category/CategoryList.dart';
import '../pages/category/GoodsDetail.dart';
import '../pages/home/Search.dart';

final routes = {
  '/':(context) => TabsPage(),
  '/categoryList':(context,{arguments})=>CategoryList(arguments:arguments),
  '/homeSearch':(context) => SearchPage(),
  '/goodsDetail':(context,{arguments})=>GoodsDetail(arguments:arguments)
};

//路由统一处理
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
