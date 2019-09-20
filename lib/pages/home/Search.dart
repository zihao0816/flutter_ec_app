import 'package:flutter/material.dart';
import '../../pluginPachaging/Screenutil.dart';
import './widgets/HotSearch.dart';
import '../../components/StorageData.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var flag = false;
  var keyword;
  @override
  Widget build(BuildContext context) {
    Screenutil.init(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:Container(
            height: Screenutil.height(58),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromRGBO(235, 235, 235, 0.9),
            ),
            child:TextField(
                  onChanged: (value) {
                    setState(() {
                      this.keyword = value;
                    });
                  },
                  onSubmitted: (value){
                    StorageData.setData(this.keyword);
                    Navigator.pushReplacementNamed(context, '/categoryList',arguments: {
                      "keywords":value
                    });
                  },
                  // maxLines: 20,
                  cursorColor:Colors.grey,
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    // hintText: '请输入搜索内容',
                    contentPadding: EdgeInsets.all(Screenutil.width(10)),
                    prefixIcon:Icon(Icons.search, size: 18,color:Color.fromRGBO(133, 133, 133, 0.9)),
                    suffixIcon:GestureDetector(
                      child: Icon(Icons.photo_camera, size: 18,color:Color.fromRGBO(133, 133, 133, 0.9)),
                      onTap: (){},
                    ),
                    border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
          ),
          
          actions: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: Screenutil.width(20)),
                alignment: Alignment.center,
                child: Text(
                  '搜索',
                  style: TextStyle(color: Color.fromRGBO(129, 132, 139, 1)),
                ),
              ),
              onTap: () {
               
                  StorageData.setData(this.keyword);
                  Navigator.pushReplacementNamed(context, '/categoryList',arguments: {
                    "keywords":this.keyword
                  });
                
                
              },
            )
          ],
        ),
        body:HotSearch() );
  }
}
