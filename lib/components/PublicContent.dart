import 'package:flutter/material.dart';
import '../pluginPachaging/Screenutil.dart';
class PublicContent extends StatelessWidget {
  final String values ;
  const PublicContent({Key key,@required this.values}):super(key:key);

   Widget publicContent(value){
    return Container(
      margin:EdgeInsets.fromLTRB(Screenutil.width(20.0), 0, Screenutil.width(20.0), 0),
      padding:EdgeInsets.only(left:Screenutil.width(14.0) ),
      decoration: BoxDecoration(
        border:Border(
          left:BorderSide(
            color:Colors.red,
            width:Screenutil.width(8.0)
          )
        )
      ),
      child:Text(
        value,
        style:TextStyle(
          color: Colors.black54
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return publicContent(this.values);
  }
}