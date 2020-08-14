import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AdAdvertisement extends StatefulWidget {
  @override
  _AdAdvertisementState createState() => _AdAdvertisementState();
}

class _AdAdvertisementState extends State<AdAdvertisement> {
  var selectedCurrency;
  var value;
  
  void ValueChanged(currencyValue){
    if(currencyValue=="Animals"){}
    else if(currencyValue=="Vehicles"){}
    setState(() {
          value =currencyValue;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text('Advertisement'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Text('Select catagory here'),
            SizedBox(height: 40.0),
            StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection("catagory_names").snapshots(),
                      builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      List<DropdownMenuItem> currencySub = [];
                      //for (int i = 0; i < snapshot.data.documents.length; i++) {
                      //  DocumentSnapshot snap = snapshot.data.documents[i];
                      //  for (int j = 0; j < snap.data.length; j++) {
                      //    currencyItems.add(
                      //      DropdownMenuItem(
                      //        child: Text(
                      //          snap.data['${j + 1}'].toString(),
                      //          style: TextStyle(color: Color(0xff11b719)),
                      //        ),
                      //        value: snap.data['${j + 1}'].toString(),
                      //      ),
                      //    );
                      //  }
                      //}
                      for(int i=0;i<snapshot.data.documents.length;i++){
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                                 //snap.data.values.toString(),
                                 snap.documentID
                            ),
                            value: "${snap.documentID}",
                            
                          ),
                        );

                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) => ValueChanged(currencyValue), 
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Currency Type",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                      
                    }
                  }),
                  SizedBox(
                height: 150.0,
              ),
              

            
          ],
        ),
    );
  }
}