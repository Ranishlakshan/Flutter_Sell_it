import 'package:betapro/uploadpg.dart';
import 'package:flutter/material.dart';
import 'aditem.dart';
import 'admob_pg.dart';
import 'admobdoc.dart';
import 'aliexpressmain.dart';
import 'catagories.dart';
import 'hotdeals.dart';
import 'location.dart';
import 'login_page.dart';
import 'searchApp.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AliExpressesPg(),
      
      routes: {
        '/aliexpresspg': (context) => AliExpressesPg(),
        '/login': (context) => LoginPage(),
        '/admobpg': (context) => AdmobPg(),
        '/admobdoc': (context) => AdmobDoc(),
        '/searchtest' : (context) => SearchHere(),
        '/uploadwait' : (context) => Uploadpg(),
        '/adadvertisement' : (context) => AdAdvertisement(),
        '/catago' : (context) => Catagories(),
        '/hotdeals' : (context) => HotDeals(),
        '/location' : (context) => Location(),
        //AdAdvertisement
        '/aditem' : (context) => AdAdvertisement(),
      },
    );
  }
}