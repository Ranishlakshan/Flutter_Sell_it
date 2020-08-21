import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemView extends StatefulWidget {
  final String docID123;

  const ItemView({ this.docID123}) ;

  @override
  _ItemViewState createState() => _ItemViewState();
}
String name123;
class _ItemViewState extends State<ItemView> {
  @override
  //String docuID = Widget.documentid;
  
  Widget build(BuildContext context) {
    //final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    //docID = ${rcvdData['docuID'];}
    //String name123  = rcvdData[0];
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Data'),
      ),
      body: ListView(
        children: <Widget>[
          Text(widget.docID123),
          getItems(),
        ],
      ),
    );
  }
}


Widget getItems(){
    return StreamBuilder(
      //1597917013710
      stream: Firestore.instance.collection('ads').document('1597917013710').snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(snapshot.data['brand']);
      }
    );
}


Future getCatagory() async {
      var firestone = Firestore.instance;

      QuerySnapshot alldata = await firestone.collection("catagory_names/Vehicles").getDocuments();
      for(int i=0;i<alldata.documents.length;i++){
                        DocumentSnapshot snap = alldata.documents[i];
                        
                      }

      return  Text('12345');

    }