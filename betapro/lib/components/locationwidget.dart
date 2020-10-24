import 'package:betapro/components/locationclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var location1 = Firestore.instance.collection("location").snapshots();

class LocationAdd extends StatefulWidget {
  Locationclass locationDetails;

  LocationAdd({this.locationDetails});

  @override
 _LocationAddState createState() => _LocationAddState();
}

class _LocationAddState extends State<LocationAdd> {

  var location1selected,location2selected;

  Locationclass loccz = Locationclass();
  
  //

  //

  List<DropdownMenuItem> locationlist2 = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: location1,
      builder:  (context, snapshot) {
              if (!snapshot.hasData){
                return Text("Loading.....");
              }else{
                List<DropdownMenuItem> locationlist1 = [];
                //locationlist1.remove("Colombo");
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    locationlist1.add(
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
                      items: locationlist1,
                      onChanged: (locval1){
                        setState(() {
                          //loccz.districtname = locval1; 
                          //loccz.setdistrict(locval1);
                          //locationDetails.setdistrict(locval1);  
                          widget.locationDetails.setdistrict(locval1);                       
                        });
                        for (int i = 0;i < snapshot.data.documents.length;i++){
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          if (snap.documentID == widget.locationDetails.getdistrictName()){
                              locationlist2 = [];
                              for (int j = 0; j < snap.data.length; j++) {
                                locationlist2.add(
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
                              'You Selected $widget.locationDetails.getdistrictName()',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                      },
                      value: widget.locationDetails.getdistrictName(),
                      isExpanded: false,
                      hint: new Text(
                        "Select your District",
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                    ),
                    DropdownButton(
                      items: locationlist2,
                      onChanged: (locval2) {
                        setState(() {
                          widget.locationDetails.settown(locval2);                        
                          });
                          final snackBar = SnackBar(
                            content: Text(
                              'You Selected $widget.locationDetails.getTownname()',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            //widget.locationDetails.settown(locval2);
                            locationlist1 = [];
                            locationlist2 = [];
                          });
                        },
                        value: widget.locationDetails.getTownname(),
                        hint: new Text(
                          "Select your City",
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                    ),
                  ],
                );
              }
                  
            },
    );
  }
}
