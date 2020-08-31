import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'zoomImage.dart';



class ItemView extends StatefulWidget {
  final String docID123;

  const ItemView({ this.docID123}) ;

  @override
  _ItemViewState createState() => _ItemViewState();
}
String name123;
var cars;
var cars_img;
class _ItemViewState extends State<ItemView> {
  @override
  //String docuID = Widget.documentid;
  
  List<String> _listOfImages = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('ads')
        .document('${widget.docID123}')
        .snapshots();
    super.initState();

    cars_img = Firestore.instance
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
          StreamBuilder(
                stream: cars_img,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _listOfImages = [];
                    for (int i = 0; i < snapshot.data['urls'].length; i++) {
                      _listOfImages.add(snapshot.data['urls'][i]);
                    }
                  }
                  return CarouselSlider(
                      items: _listOfImages.map((e){
                        return ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 200.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                  //image appear in correct width and height
                                  //child: Image.network(e, fit: BoxFit.fill),
                                  child: Image.network(e),
                                  onTap: () {
                                    Navigator.push<Widget>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ZoomImage(zoomlistOfImages: _listOfImages),
                                      ),
                                    );
                                  }),
                            ));
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ));
                }),
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
        List<String> viewList =[]; 
        List<String> spec_list = urlremoved.split(", ");
        for(int j=0;j<spec_list.length;j++){
          if(!(spec_list[j].contains('value') || spec_list[j].contains('searchkey')  || spec_list[j].contains('reviewstatus')) ){
            viewList.add(spec_list[j]);
          }
        }
        int speclistlen = spec_list.length;
        int viewlistlen = viewList.length;
        //
        return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: viewlistlen,
                itemBuilder: (context,index){
                  return Card(
                    //child: Text(spec_list[index])
                    child: Column(
                      children: <Widget>[
                        Text(viewList[index]),
                        
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