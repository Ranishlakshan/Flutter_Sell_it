import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';

class SearchHere extends StatefulWidget {
  @override
  _SearchHereState createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  

  String carBand;
  String carYear;
  String carImage;
  String docID;
  CarModel carObjec123 = new CarModel("","","","");
  var searchitem;
  List<CarModel> _listOfObjects = <CarModel>[];

  bool searchState = false;

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

  //@override
  //void initState() {
  //  // TODO: implement initState
  //  carObjec.getSearch().then((result) {
  //    setState(() {
  //      car = result;
  //    });
  //  });
  //  super.initState();
  //}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !searchState?Text("Search"):
        TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'search here',
            hintStyle: TextStyle(color: Colors.white)
          ),
          onChanged: (text){
            searchmethod(text);
            carObjec123.getSearch(text).then((result) {
            setState(() {
            searchitem = result;
            });
    });
          } ,
        ),
        actions: <Widget>[
            !searchState?IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  searchState= !searchState;                  
                });
                //addDialog(context);
              },
            ):
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  searchState= !searchState;                  
                });
                //addDialog(context);
              },
            ),
            
          ],
      ),
      body: ListView(
        children: <Widget>[
            StreamBuilder(
            stream: searchitem,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                _listOfObjects = <CarModel>[];
                
                 for (int i = 0; i < snapshot.data.documents.length; i++) {
                  // DocumentSnapshot snap = snapshot.data.documents[i];
                  
                  String docID = snapshot.data.documents[i].documentID;
                  String carBrand =
                      snapshot.data.documents[i].data['brand'];
                  String caryear = snapshot.data.documents[i].data['model'];
                  String carimage =
                      snapshot.data.documents[i].data['urls'][0];                  
                  _listOfObjects.add(CarModel(carBrand,caryear,carimage,docID));
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
  void searchmethod(String text) {}
}