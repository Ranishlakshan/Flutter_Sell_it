import 'package:betapro/searchApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/locationSearchClass.dart';
import 'dbmodels/car_itm_model.dart';



class Location extends StatefulWidget {
  var locationsnap = Firestore.instance.collection("location").snapshots();
  LocationSearchclass receive;

  Location({this.receive});
  

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  CarModel carObjec = new CarModel("", "", "", "","","");

  List<DropdownMenuItem> locationtownsearch = [];
  //String searchtype="SRILANKA";
  //LocationSearchclass lsc = LocationSearchclass('','','SRILANKA');

  var allsearchsnap;
  
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Loation"),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
                  child: Text('All in SriLanka'),
                  onPressed:(){
                    setState(() {
                      //searchtype="SRILANKA"; 
                      //widget.lsc.searchtype="SRILANKA"; 
                      widget.receive.searchtype="SRILANKA";
                                           
                    });
                    Navigator.pop(context);
                  },

                ),
          SizedBox(height: 30,),
          Container(
            child: Center(
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
                          widget.receive.setSearchdistrict(value);
                          widget.receive.setSearchType("DISTRICT");
                          //searchtype="DISTRICT";
                        });
                          for (int i = 0;i < snapshot.data.documents.length;i++){
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          if (snap.documentID == widget.receive.getSearchdistrictName()){
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
                              'You Selected $widget.receive.getSearchdistrictName()',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);

                      }
                      catch(e){
                        print("error happened");
                      }  
                      
                      },
                      value: widget.receive.getSearchdistrictName(),
                      isExpanded: false,
                      hint: new Text(
                        "Search District",
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                    ),
                    DropdownButton(
                      items: locationtownsearch,
                      onChanged: (value){

                        try{
                          setState(() {
                            widget.receive.setSearchtown(value);
                            //town = value;

                          });
                          final snackBar = SnackBar(
                              content: Text(
                                'You Selected $widget.receive.getSearchTownname()',
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

                        
                      print(widget.receive.searchdistrict+","+widget.receive.getSearchTownname()+","+widget.receive.getSearchType());  
                      
                      },
                      //icon: Icon(Icons),
                       
                      value: widget.receive.getSearchTownname(),
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
            )
          ),
          Text("LOCATION"),
        ],
      ),
    );
  }
}