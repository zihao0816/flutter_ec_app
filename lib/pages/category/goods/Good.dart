import 'package:flutter/material.dart';

class GoodPage extends StatefulWidget {
  GoodPage({Key key}) : super(key: key);

  _GoodPageState createState() => _GoodPageState();
}

class _GoodPageState extends State<GoodPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('商品'),
    );
  }
}