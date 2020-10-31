import 'package:flutter/material.dart';

import 'drawer.dart';

class HotDeals extends StatefulWidget {
  @override
  _HotDealsState createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hot Deals"),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: Text("Hot Deals"),
            ),
          )
        ],
      ),
      
    );
  }
}