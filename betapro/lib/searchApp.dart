import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnvbar.dart';
import 'components/locationSearchClass.dart';
import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';
import 'drawer.dart';
import 'location.dart';
import 'locationtemp.dart';

var locationsnap = Firestore.instance.collection("search_location").snapshots();
//String ranmal = "I am done";
//List<DropdownMenuItem> locationlistsearch = [];

class SearchHere extends StatefulWidget {

  //LocationSearchclass receive2;
  //String dis,tow,typ;
  //List lst1 = List();
  //SearchHere({lst1});  
  

  @override
  _SearchHereState createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  String carBand;
  String carYear;
  String carImage;
  String docID;

  //String dis1 = dis;

  CarModel carObjec = new CarModel("", "", "", "","","");

  List<CarModel> _listOfObjects = <CarModel>[];

  var allsearchsnap;

  String district,town,temptown;
  List<DropdownMenuItem> locationtownsearch = [];
  String searchtype="SRILANKA";
  String serchlocation;

  //LocationSearchclass searchLocation = LocationSearchclass(" "," ","SRILANKA");

  //String ddd ;
  //String ttt;

  @override
  void initState() {
    // TODO: implement initState
    //searchLocation.setSearchType("SRILANKA");
     //ddd = searchLocation.getSearchTownname();
     //ttt = searchLocation.getSearchdistrictName();
     
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
  String ranish;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search",style: TextStyle( letterSpacing: 2),),
        
        actions: <Widget>[
            
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
        children: <Widget>[
        //ADD new location selectdetails here
        SizedBox(height: 10,),
        Container(
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(
          flex: 1,
          child: Container(
            //child: RaisedButton(
            //  child: Text('All of Sri Lanka'),
            //  onPressed: (){
            //    //press function
            //    setState(() {
            //      searchtype="SRILANKA";                  
            //    });
            //  },
            //),
            child: whatuSearch(),
            width: MediaQuery.of(context).size.width * 0.25,
            //decoration: BoxDecoration(color: Colors.greenAccent),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
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
                        //
                      try{
                        setState(() {
                          if(value=="<< All of Sri Lanka >>"){
                            searchtype="SRILANKA";
                            district=null;
                            town=null;
                          }
                          else{
                            pressed="B";
                            district=null;
                            town=null;
                            district=value;
                            //searchtype="DISTRICT";
                            searchtype="DISTRICT";
                          }
                          
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

                      }
                      catch(e){
                        print("error happened");
                      }  
                      
                      },
                      value: district,
                      isExpanded: false,
                      hint: new Text(
                        "Select Location",
                        style: TextStyle(color: Color(0xff11b719),fontSize: 20),
                        
                      ),
                    ),
                    DropdownButton(
                      items: locationtownsearch,
                      onChanged: (value){

                        try{
                          setState(() {
                            pressed="A";
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
                        }
                        catch(e){
                          print('error happened 2');
                        }

                        //setState(() {
                        //  town = value;
                        //                  
                        //});
                        //final snackBar = SnackBar(
                        //    content: Text(
                        //      'You Selected $town',
                        //      style: TextStyle(color: Color(0xff11b719)),
                        //    ),
                        //  );
                        //  Scaffold.of(context).showSnackBar(snackBar);
                        //  setState(() {
                        //    //widget.locationDetails.settown(locval2);
                        //    locationlistsearch = [];
                        //    locationtownsearch = [];
                        //  });
                      
                      },
                      //icon: Icon(Icons),
                       
                      value: town,
                      isExpanded: false,
                      hint: new Text(
                        "Select City",
                        style: TextStyle(color: Color(0xff11b719),fontSize: 20),
                      ),
                    ),
                  ],
                );
              }
            }
          ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.25,
            //decoration: BoxDecoration(color: Colors.yellow),
          ),
        ),
        
              ],
            )
          ),
        ),

        //--END- //ADD new location selectdetails here
        TextField(
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            hintText: 'Search Here',
            labelText: 'Search ',
            prefixIcon: Icon(Icons.search)
          ),
          onChanged: (value) {
            searchValue = value;

          },
        ),
        SizedBox(height: 20,),

          RaisedButton(
             onPressed: () {
              setState(() {
                //remove keyboard from screen
                FocusScope.of(context).unfocus();
                pressed = "A";
              });
            },
            color: Color(0xff11b719),
            
              textColor: Colors.white,
              child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Search", style: TextStyle(fontSize: 21.0)),
                ],
              )
              ),
            
          ),
          
          SizedBox(height: 15,),


    
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
                  
                  //
                  //
                  //TRY NEW CODE FROM HERE
                  //searchValue;
                  List<String> search_List = searchValue.split(" ");
                  print("NO OF WORDS :${search_List.length}");
                  //--END---TRY NEW CODE FROM HERE

                  if(search_List.length==1){
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
                      if(town.contains("All Ads in")){
                        temptown=town.substring(1 + town.lastIndexOf(' '));
                        print(temptown);
                        if(serchText.contains(searchValue) & serchlocation.contains(temptown)){
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
                  }
                  else if(search_List.length==2){
                      if(searchtype=="SRILANKA"){
                        if (serchText.contains(search_List[0] ) && serchText.contains(search_List[1])) {
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
                  else if(search_List.length>2){
                      if(searchtype=="SRILANKA"){
                        if (serchText.contains(search_List[0] ) && serchText.contains(search_List[1]) && serchText.contains(search_List[2] )) {
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




                  ///---START--------------------------------
                  //if(searchtype=="SRILANKA"){
                  //  if (serchText.contains(searchValue)) {
                  //    docID = snapshot.data.documents[i].documentID;
                  //    value1 = snapshot.data.documents[i].data['value1'];
                  //    value2 = snapshot.data.documents[i].data['value2'];
                  //    value3 = snapshot.data.documents[i].data['value3'];
                  //    value4 = snapshot.data.documents[i].data['value4'];
                  //    carimage = snapshot.data.documents[i].data['urls'][0];
                  //  
                  //    _listOfObjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
                  //  }
                  //}
                  //else{
                  //  if(serchText.contains(searchValue) & serchlocation.contains(town)){
                  //    docID = snapshot.data.documents[i].documentID;
                  //    value1 = snapshot.data.documents[i].data['value1'];
                  //    value2 = snapshot.data.documents[i].data['value2'];
                  //    value3 = snapshot.data.documents[i].data['value3'];
                  //    value4 = snapshot.data.documents[i].data['value4'];
                  //    carimage = snapshot.data.documents[i].data['urls'][0];
                  //  
                  //    _listOfObjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
                  //  }
                  //}
                  //--END-------------------------------------

                  
                }
                return sliverGridWidget(context);
              } 
              else {//!snapshot.hasdata
                return Text("loading");
              }
            },
          );
    }else{
      return Text(' ');
    }
    
  }
 

  Widget whatuSearch(){
    //return Text('data');
  if(searchtype=="SRILANKA"){
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.location_on),
            Text("All of Sri Lanka")
          ],
        ),
      ),
    );
  }
  else{
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.location_on),
            Text("${town},${district}")
          ],
        ),
      ),
    );
  }
    //print(widget.lserecevce.searchdistrict);
    //if(widget.receive2.searchtype==null){
    //  return Center(
    //    child: Card(
    //      child: Text("Search in : All around Sri Lanka", style: TextStyle(fontSize: 16, ),),
    //    ),
    //  );
    //}
    //else{
    //  if(widget.receive2.searchtype=="SRILANKA"){
    //    return Center(
    //      child: Card(
    //        child: Text("Search in : All around Sri Lanka", style: TextStyle(fontSize: 16, ),),
    //      ),
    //    );
    //  }else{
    //    return Center(
    //      child: Card(
    //        child: Text("Search in : Other", style: TextStyle(fontSize: 16, ),),
    //      ),
    //    );
    //  }
    //}

    
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