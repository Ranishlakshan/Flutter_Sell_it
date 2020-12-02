import 'package:betapro/uploadpg.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'aditem.dart';
import 'admob_pg.dart';
import 'admobdoc.dart';
import 'aliexpressmain.dart';
import 'catagories.dart';
import 'hotdeals.dart';
import 'location.dart';
import 'login_page.dart';
import 'searchApp.dart';
import 'specialcategory/specialElectronics.dart';
import 'specialcategory/specialEssentials.dart';
import 'specialcategory/specialFashion.dart';
import 'specialcategory/specialHome.dart';
import 'specialcategory/specialVehicle.dart';


void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
       
      seconds: 2,
      navigateAfterSeconds: new AfterSplash(),
      
      title: new Text(
        'Welcome to FastLK',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0,color: Colors.white),
      ),
      //image: Image(image: AssetImage('images/mainimage.png'), width: 300,height: 300,),
      
      backgroundColor: Colors.black,
      loaderColor: Colors.white,
      //imageBackground: AssetImage('images/mainimage.png'),
    );
  }
}


class AfterSplash extends StatelessWidget {
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
        //SpecialVehicles
        '/specialvehicles' : (context) => SpecialVehicles(),
        //SpecialElectronics
        '/specialElectronics' : (context) => SpecialElectronics(),
        //SpecialHome
        '/specialHomes' : (context) => SpecialHome(),
        //SpecialFashion
        '/specialFashion' : (context) => SpecialFashion(),
        //SpecialEssentials
        '/specialEssentials' : (context) => SpecialEssentials(),


      },
    );
  }
}