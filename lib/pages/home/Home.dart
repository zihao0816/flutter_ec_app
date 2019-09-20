import 'package:flutter/material.dart';
import '../../pluginPachaging/Screenutil.dart';
import '../../components/PublicContent.dart';
import './widgets/Swiper.dart';
import './widgets/ImageText.dart';
import './widgets/MainImage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
   @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    Screenutil.init(context);
    return Scaffold(
      body:ListView(
        children: <Widget>[
            SwiperPage(),
            PublicContent(values:'猜你喜欢'),
            SizedBox(height:Screenutil.height(20.0)),
            ImageText(),
            PublicContent(values:'热门推荐'),
            MainImage()
        ],
      )
    );
  }

}