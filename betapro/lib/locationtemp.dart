import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:betapro/searchApp.dart';


import 'components/locationSearchClass.dart';

var locationsnap = Firestore.instance.collection("location").snapshots();
  

class LocationTemp extends StatefulWidget {

  LocationSearchclass receive;

  LocationTemp({this.receive});

  @override
  _LocationTempState createState() => _LocationTempState();
}

class _LocationTempState extends State<LocationTemp> {


  List<DropdownMenuItem> locationtownsearch = [];

  String town,district,type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Loation"),

      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          SizedBox(height: 30,),
          RaisedButton(
            child: Text('All in SriLanka'),
            onPressed:(){
              setState(() {
                //searchtype="SRILANKA"; 
                //widget.lsc.searchtype="SRILANKA"; 
                type="SRILANKA";                      
              });
              Navigator.pop(context);
            }
          ),
          SizedBox(height: 30,),
          SizedBox(height: 30,),
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
                          //lsc.setSearchdistrict(null);
                          //lsc.setSearchtown(null);
                          //widget.receive.setSearchdistrict(value);
                          //district=null;
                          //town=null;
                          district=value;
                          town=null;
                          //widget.receive.setSearchType("DISTRICT");
                          type="DISTRICT";
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
                        "Search District",
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                    ),
                    DropdownButton(
                      items: locationtownsearch,
                      onChanged: (value){

                        try{
                          setState(() {
                            //widget.receive.setSearchtown(value);
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

                      print(district+","+town+","+type); 
                      //widget.receive.searchdistrict=district;
                      //widget.receive.searchTown=town;
                      //widget.receive.searchtype=type;
                      //print(widget.receive.searchdistrict+","+widget.receive.searchTown+","+widget.receive.searchtype);  
                      Navigator.pop(context,"yep hoo");
                      //List lst = List();
                      //lst.add(district);
                      //lst.add(town);
                      //lst.add(type);
                      //Navigator.push(context,MaterialPageRoute(
                      //  builder: (context) => SearchHere(lst1:lst ),
                      //));
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
    );
  }
}