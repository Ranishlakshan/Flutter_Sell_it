import 'package:flutter/material.dart';
import 'admob_pg.dart';
import 'dashboard.dart';
import 'login_page.dart';
import 'search.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routeName;
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/searchitem': (context) => SeachAppBarRecipe(),
        '/admobpg': (context) => AdmobPg(),
      },
    );
  }
}