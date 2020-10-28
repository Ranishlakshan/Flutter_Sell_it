import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';

var catagory_names = Firestore.instance.collection("catagory_names").snapshots();
var catagoryMain,catagorySub;
String showItems;

class Catagories extends StatefulWidget {
  @override
  _CatagoriesState createState() => _CatagoriesState();
}

class _CatagoriesState extends State<Catagories> {

  List<CarModel> _catagoryCbjects = <CarModel>[];
  CarModel itemObject = new CarModel("", "", "", "","","");

  var ads;

  @override
  void initState() {
    // TODO: implement initState
    itemObject.getData().then((result) {
      setState(() {
        ads = result;
      });
    });
    super.initState();
  }


  List<DropdownMenuItem> catagoryNamesSub = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catagories"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/searchtest');
                //addDialog(context);
              },
            ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Text('Ranish'),
          StreamBuilder(
            stream: catagory_names,
            builder:  (context, snapshot) {
              if (!snapshot.hasData){
                return Text("Loading.....");
              }
              else {
                List<DropdownMenuItem> catagorynamesMain = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    catagorynamesMain.add(
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
                        items: catagorynamesMain,
                        onChanged: (value) {
                          setState(() {
                            catagoryMain=value;                            
                          });
                          for (int i = 0;i < snapshot.data.documents.length;i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            if (snap.documentID == catagoryMain) {
                              catagoryNamesSub = [];
                              for (int j = 0; j < snap.data.length; j++) {
                                catagoryNamesSub.add(
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
                              'Selected Catogory : $catagoryMain',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        value: catagoryMain,
                        
                        isExpanded: false,
                        hint: new Text(
                          "Select Catagory Here",
                          style: TextStyle(color: Color(0xff11b719)),
                        ),  
                      ),
                      DropdownButton(
                        hint: Text("Select Sub Catagory Here"),
                        items: catagoryNamesSub,
                        onChanged: (value) {
                          final snackBar = SnackBar(
                            content: Text(
                            'Selected Currency value is $value',
                            style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            showItems="A";
                            catagorySub = value;
                            catagorynamesMain = [];
                            catagoryNamesSub= [];
                          });
                        },
                      ),
                      _showCatagory(),
                    ],
                  );
              }              
            },
          ),
        ],
      ),
      
    );
    
    ///
  }

  //
  //ADDITIONAL wIDGET FROM HERE
  //
  Widget _showCatagory(){
    if(showItems=="A"){
      //Show catagory data here
      return StreamBuilder(
        stream: ads,
        builder:  (context, snapshot) {
          if(!snapshot.hasData){
            return Text('No Data for This Catagory');
          }
          else{
            _catagoryCbjects = <CarModel>[];

            for (int i = 0; i < snapshot.data.documents.length; i++){

              String dbCatagory = snapshot.data.documents[i].data['catagory'];
              String value1,value2,value3,value4,carimage,docID;

              if (dbCatagory.contains(catagorySub)) {
              docID = snapshot.data.documents[i].documentID;
              value1 = snapshot.data.documents[i].data['value1'];
              value2 = snapshot.data.documents[i].data['value2'];
              value3 = snapshot.data.documents[i].data['value3'];
              value4 = snapshot.data.documents[i].data['value4'];
              carimage = snapshot.data.documents[i].data['urls'][0];
            
              _catagoryCbjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
            }
            }
            return sliverGridWidget(context);
          }          
        },
      );



    }else{
      return Text(' ');
    }
  }

  Widget sliverGridWidget(context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _catagoryCbjects.length, //staticData.length,

      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(_catagoryCbjects[index]);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}