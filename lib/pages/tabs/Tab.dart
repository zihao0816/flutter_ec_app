import 'package:flutter/material.dart';
import '../home/Home.dart';
import '../my/My.dart';
import '../shop/Shop.dart';
import '../category/Category.dart';
import '../../pluginPachaging/Screenutil.dart';
class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);
  _TabsPageState createState() => _TabsPageState();
}
class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;
  List<Widget> currentList = [
    HomePage(),
    CategoryPage(),
    ShopPage(),
    MyPage()

  ];
  PageController _pageController;
  @override
  void initState() { 
    super.initState();
    _pageController =new PageController(initialPage:this._currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    Screenutil.init(context);
    return Scaffold(
        appBar: this._currentIndex==0||this._currentIndex==1?AppBar(
          elevation:0,
          leading: InkWell(
            child: Icon(
              IconData(
                0xe615,
                fontFamily:'Schyler'
              )
            ),
            onTap:null
          ),
          title: GestureDetector(
            onTap:(){
              Navigator.pushNamed(context, '/homeSearch');
            },
            child: Container(
              width:double.infinity,
              height:Screenutil.height(58),
              padding:EdgeInsets.only(left:10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color:  Color.fromRGBO(235, 235, 235, 0.9),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search,color:Color.fromRGBO(133, 133, 133, 0.9),size:18),
                  Container(
                    margin:EdgeInsets.only(left:10),
                    child: Text('华为',style:TextStyle(
                    color: Color.fromRGBO(133, 133, 133, 0.9),
                    fontSize: 12.0
                  )),
                  )
                  
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Container(
              margin:EdgeInsets.only(right:10),
              child:Icon(Icons.camera) ,
            )
          ],
        ):null,
        body:PageView(
          controller:_pageController ,
          children:this.currentList,
          onPageChanged: (index){ 
            setState(() {
              this._currentIndex = index;
            });
          },
          physics:NeverScrollableScrollPhysics()
        ),
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (index){
            setState(() {
             this._currentIndex  = index;
             this._pageController.jumpToPage(this._currentIndex);
            });
            
          },
          fixedColor: Colors.red,
          type:BottomNavigationBarType.fixed,
           items: [
             BottomNavigationBarItem(
               icon: Icon(Icons.home),
               title:Text('首页')
             ),
              BottomNavigationBarItem(
               icon: Icon(Icons.category),
               title:Text('分类')
             ),
              BottomNavigationBarItem(
               icon: Icon(Icons.shopping_cart),
               title:Text('购物车')
             ),
              BottomNavigationBarItem(
               icon: Icon(Icons.people),
               title:Text('我的')
             )
           ], 
        ),
      );
  }
}