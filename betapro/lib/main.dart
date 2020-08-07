import 'package:flutter/material.dart';
import 'aditems.dart';
import 'admob_pg.dart';
import 'admobdoc.dart';
import 'dashboard.dart';
import 'first_screen.dart';
import 'login_page.dart';
import 'search.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var routeName;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/searchitem': (context) => SeachAppBarRecipe(),
        '/admobpg': (context) => AdmobPg(),
        '/admobdoc': (context) => AdmobDoc(),
        '/first_screen': (context) => FirstScreen(),
        '/ad_items': (context) => AdItem(),
      },
    );
  }
}