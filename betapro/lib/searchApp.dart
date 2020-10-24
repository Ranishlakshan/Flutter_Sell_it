import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';

var locationsnap = Firestore.instance.collection("location").snapshots();

class SearchHere extends StatefulWidget {
  @override
  _SearchHereState createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  String carBand;
  String carYear;
  String carImage;
  String docID;

  CarModel carObjec = new CarModel("", "", "", "","","");

  List<CarModel> _listOfObjects = <CarModel>[];

  var allsearchsnap;

  String district,town,temptown;
  List<DropdownMenuItem> locationtownsearch = [];
  String searchtype;
  String serchlocation;

  @override
  void initState() {
    // TODO: implement initState
    carObjec.getData().then((result) {
      setState(() {
        allsearchsnap = result;
      });
    });
    super.initState();
  }

  String searchValue;
  String pressed;
  String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search Here',
            labelText: 'Search',
          ),
          onChanged: (value) {
            searchValue = value;
          },
        ),
        
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                pressed = "A";
              });
            },
            child: Text(
              "Search",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[

          TextField(
          decoration: const InputDecoration(
            hintText: 'Search Here',
            labelText: 'Search',
          ),
          onChanged: (value) {
            searchValue = value;
          },
        ),
        SizedBox(height: 20,),

          //TextField(
          //  decoration: const InputDecoration(
          //  hintText: 'Enter Location here',
          //  labelText: 'Add specific location (Optional)',
          //),
          //onChanged: (value) {
          //  location = value;
          //},
          //),
          ////
          /////
          ///
          ///
          ///
          
          Row(
            
            children: <Widget>[
              SizedBox(width: 20,),
              Expanded(
                child: RaisedButton(
                  child: Text('All in SriLanka'),
                  onPressed:(){
                    setState(() {
                      searchtype="SRILANKA";                      
                    });
                  },

                ),
              ),
              //SizedBox(width: 30,),
              Expanded(
                child:Text("OR"),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                children: <Widget>[
                  StreamBuilder(
            stream: locationsnap,
            builder: (context, snapshot) {
              if (!snapshot.hasData){
                return Text("Loading.....");
              }else{
                List<DropdownMenuItem> locationlistsearch = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    locationlistsearch.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                      value: "${snap.documentID}",
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    DropdownButton(
                      items: locationlistsearch,
                      onChanged:(value){
                        setState(() {
                          district=value;
                          searchtype="DISTRICT";
                        });
                        for (int i = 0;i < snapshot.data.documents.length;i++){
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          if (snap.documentID == district){
                              locationtownsearch = [];
                              for (int j = 0; j < snap.data.length; j++) {
                                locationtownsearch.add(
                                  DropdownMenuItem(
                                    child: Text(
                                      snap.data['${j + 1}'].toString(),
                                      style:
                                          TextStyle(color: Color(0xff11b719)),
                                    ),
                                    value: snap.data['${j + 1}'].toString(),
                                  ),
                                );
                              }
                          }
                        }
                        final snackBar = SnackBar(
                            content: Text(
                              'You Selected $district',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                      },
                      value: district,
                      isExpanded: false,
                      hint: new Text(
                        "Search District",
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                    ),
                    DropdownButton(
                      items: locationtownsearch,
                      onChanged: (value){
                        setState(() {
                          town = value;
                                          
                        });
                        final snackBar = SnackBar(
                            content: Text(
                              'You Selected $town',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            //widget.locationDetails.settown(locval2);
                            locationlistsearch = [];
                            locationtownsearch = [];
                          });
                      
                      },
                      //icon: Icon(Icons),
                       
                      value: town,
                      isExpanded: false,
                      hint: new Text(
                        "Select your City",
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                    ),
                  ],
                );
              }
            }
          ),
                ],
              ),
              ),
              SizedBox(width: 30,),
            ],
          ),
          //
          //
          //
          //
          whatuSearch(),
          //Text('You are going to search in ${town},${district}'),
          RaisedButton(
             onPressed: () {
              setState(() {
                pressed = "A";
              });
            },
            child: Text(
              "Search",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          
          SizedBox(height: 30,),
          _getBody(),
        ],
      )
        
      );
    
  }


  Widget _getBody(){
    if(pressed == "A"){
      return StreamBuilder(
            stream: allsearchsnap,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _listOfObjects = <CarModel>[];

                for (int i = 0; i < snapshot.data.documents.length; i++) {
                
                  String serchText = snapshot.data.documents[i].data['searchkey'];
                  serchlocation = snapshot.data.documents[i].data['value3'];
                  String value1,value2,value3,value4,carimage,docID;
                  
                  //if (serchText.contains(searchValue)) {
                  //  docID = snapshot.data.documents[i].documentID;
                  //  value1 = snapshot.data.documents[i].data['value1'];
                  //  value2 = snapshot.data.documents[i].data['value2'];
                  //  value3 = snapshot.data.documents[i].data['value3'];
                  //  value4 = snapshot.data.documents[i].data['value4'];
                  //  carimage = snapshot.data.documents[i].data['urls'][0];
                  //
                  //  _listOfObjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
                  //}
                  if(searchtype=="SRILANKA"){
                    if (serchText.contains(searchValue)) {
                      docID = snapshot.data.documents[i].documentID;
                      value1 = snapshot.data.documents[i].data['value1'];
                      value2 = snapshot.data.documents[i].data['value2'];
                      value3 = snapshot.data.documents[i].data['value3'];
                      value4 = snapshot.data.documents[i].data['value4'];
                      carimage = snapshot.data.documents[i].data['urls'][0];
                    
                      _listOfObjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
                    }
                  }
                  else{
                    if(serchText.contains(searchValue) & serchlocation.contains(town)){
                      docID = snapshot.data.documents[i].documentID;
                      value1 = snapshot.data.documents[i].data['value1'];
                      value2 = snapshot.data.documents[i].data['value2'];
                      value3 = snapshot.data.documents[i].data['value3'];
                      value4 = snapshot.data.documents[i].data['value4'];
                      carimage = snapshot.data.documents[i].data['urls'][0];
                    
                      _listOfObjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
                    }
                  }

                  
                }
                return sliverGridWidget(context);
              } 
              else {//!snapshot.hasdata
                return Text("loading");
              }
            },
          );
    }else{
      return Text('Ranish');
    }
    
  }

  Widget whatuSearch(){
    if(searchtype== "SRILANKA"){
      return Center(
        child: Card(
          child: Text("Search in : All around Sri Lanka", style: TextStyle(fontSize: 16, ),),
        ),
      );
    }
    else{
      return Center(
        child: Card(
          child: Text("Search in : ${town},${district}"),
        ),
      );
    }
  }


  Widget sliverGridWidget(context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _listOfObjects.length, //staticData.length,

      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(_listOfObjects[index]);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}