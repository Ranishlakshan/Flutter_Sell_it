import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'components/listview_Horizontal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';
import 'drawer.dart';
import 'staggardgridview.dart';


class AliExpressesPg extends StatefulWidget {
  @override
  _AliExpressesPgState createState() => _AliExpressesPgState();
}

class _AliExpressesPgState extends State<AliExpressesPg> {
  
  String carBand;
  String carYear;
  String carImage;
  String docID;
  CarModel carObjec = new CarModel("","","","","","");
  var car;
  List<CarModel> _listOfObjects = <CarModel>[];

  


  final List<String> images = [
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
    "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
    "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
    "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
    "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",
  ];

  Widget sliverGridWidget(context) {
     return StaggeredGridView.countBuilder(
       padding: const EdgeInsets.all(8.0),
       shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _listOfObjects.length, //staticData.length,
      // itemBuilder: (context, index) {
      //   return Card(
      //       elevation: 8.0,
      //       child: InkWell(
      //           child: Hero(
      //             tag: index, // staticData[index].images,
      //             child: new FadeInImage(
      //               width: MediaQuery.of(context).size.width,
      //               image: NetworkImage(
      //                   "https://images.unsplash.com/photo-1468327768560-75b778cbb551?ixlib=rb-1.2.1&w=1000&q=80"), // NetworkImage(staticData[index].images),
      //               fit: BoxFit.cover,
      //               placeholder: AssetImage("assets/images/app_logo.png"),
      //             ),
      //           ),
      //           onTap: () {
      //             //
      //           }
      //           )
      //           );
      // },
      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(_listOfObjects[index]);
      },
     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
     mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      
    );

  }

  Widget carosalmain(){
    return CarouselSlider(
              items: [
            'http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg',
            'http://photo.16pic.com/00/38/88/16pic_3888084_b.jpg',
            'http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg',
            'http://photo.16pic.com/00/38/88/16pic_3888084_b.jpg'
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap: () {}));
              },
            );
          }).toList(),
          options: CarouselOptions(
          height: 200,
          aspectRatio: 16 /9 ,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
            )
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    carObjec.getData().then((result) {
      setState(() {
        car = result;
      });
    });
    super.initState();
    //print();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find what u want'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/searchtest');
                //addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                
                Navigator.pushNamed(context, '/login');
                //addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {},
            ),
          ],
      ),
      drawer: MyDrawer(),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        //shrinkWrap : true,
        children: <Widget>[
          carosalmain(),
          SizedBox(height: 20.0,),
          //Horizontal list srarts here
          MainListView(),
          SizedBox(height: 20.0,),
          Card(
            child: Text("data"),
          ),
          Card(
            child: Text("data"),
          ),
          Card(
            child: Text("data"),
          ),
          Card(
            child: Text("data"),
          ),
          Card(
            child: Text("data"),
          ),
          Card(
            child: Text("data"),
          ),
          Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          //Text("data"),
          Text("data"),
          StreamBuilder(
            stream: car,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                _listOfObjects = <CarModel>[];
                
                 for (int i = 0; i < snapshot.data.documents.length; i++) {

                  //bool status = snapshot.data.documents[i].data['reviewstatus'];
                  // DocumentSnapshot snap = snapshot.data.documents[i];
                  
                    String docID = snapshot.data.documents[i].documentID;
                    String value1 =snapshot.data.documents[i].data['value1'];
                    String value2 = snapshot.data.documents[i].data['value2'];
                    String value3 = snapshot.data.documents[i].data['value3'];
                    String value4 = snapshot.data.documents[i].data['value4'];
                    String carimage =
                        snapshot.data.documents[i].data['urls'][0];                  
                    _listOfObjects.add(CarModel(value1,value2,value3,value4,carimage,docID));
                  
                  
                  
                }
                return sliverGridWidget(context); 
              }else{
                return Text("loading");
              }
                 
                 
              },
          ),

        ],
      ),
    );
  }
}


