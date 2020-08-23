import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ItemView extends StatefulWidget {
  final String docID123;

  const ItemView({ this.docID123}) ;

  @override
  _ItemViewState createState() => _ItemViewState();
}
String name123;
var cars;
class _ItemViewState extends State<ItemView> {
  @override
  //String docuID = Widget.documentid;
  

  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('ads')
        .document('${widget.docID123}')
        .snapshots();
    super.initState();
  }

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
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          getItems(),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
          Text('Nimasha'),
        ],
      )
    );
  }
}


Widget getItems(){
    return StreamBuilder(
      //1597917013710
      //stream: Firestore.instance.collection('ads').document('1597917013710').snapshots(),
      stream: cars,
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot dd = snapshot.data; 

        //

        //
        var userDocument = snapshot.data;
        //String myname = dd.data.toString();
        int len = dd.data.length;
        //String myname = dd.data.toString();
        //List<String> list_name = new List(len);
        //List<String> list = myname.split(", ");
        //String nochar = myname.replaceAll(new RegExp(r"[^\s\w]"),'');
        //var ddd = myname.split(', ').map((String text) => Text(text));
        //return new Text(snapshot.data['brand']);
        //String sss = ddd.
        //
        String jsonString = dd.data.toString();
        String start = "[";
        String end = "]";
        final startIndex = jsonString.indexOf(start);
        final endIndex = jsonString.indexOf(end, startIndex + start.length);
        String next = jsonString.substring(startIndex + start.length, endIndex);
        String imagelinkRemoved = jsonString.replaceAll(next, "");
        String urlremoved = imagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");

        List<String> spec_list = urlremoved.split(", ");
        int speclistlen = spec_list.length;
        
        //
        return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: speclistlen,
                itemBuilder: (context,index){
                  return Card(
                    //child: Text(spec_list[index])
                    child: Column(
                      children: <Widget>[
                        Text(spec_list[index]),
                        
                      ],
                    ),
                    );
                },
              
        );

        //int i=0;
        //if(i<speclistlen){
        //  return Text (spec_list[i]);
        //} 
        //return Text(speclistlen.toString());
        //for(int i;i<5;i++){
        //  return Text(spec_list[i]);
        //}
        //List<String> items = ;
        //return new Text(list[9]);
        //return new Text(spec_list[9]);
        //return ListView(
        //  
        //  children: <Widget>[
        //    
        //  ],
        //);
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