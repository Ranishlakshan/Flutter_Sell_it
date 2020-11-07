import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnvbar.dart';
import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';
import 'drawer.dart';

class HotDeals extends StatefulWidget {
  @override
  _HotDealsState createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  
  CarModel hotdealobject = new CarModel("","","","","","");
  var hotdealstream;
  List<CarModel> hotdealobjectlist = <CarModel>[];

  @override
  void initState() {
    // TODO: implement initState
    hotdealobject.getHotdealsData().then((result) {
      setState(() {
        hotdealstream = result;
      });
    });
    super.initState();
    //print();
    
  }

  Widget sliverGridWidget(context) {
     return StaggeredGridView.countBuilder(
       padding: const EdgeInsets.all(8.0),
       shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: hotdealobjectlist.length, //staticData.length,
      
      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(hotdealobjectlist[index]);
      },
     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
     mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        title: Text("Special Offers",style: TextStyle( letterSpacing: 2),),
        backgroundColor: Colors.black,
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
          Container(
            child: Center(
              //child: Text("Hot Deals"),
            ),
          ),
          StreamBuilder(
            stream: hotdealstream,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                hotdealobjectlist = <CarModel>[];
                
                 for (int i = 0; i < snapshot.data.documents.length; i++) {

                  //bool status = snapshot.data.documents[i].data['reviewstatus'];
                  // DocumentSnapshot snap = snapshot.data.documents[i];
                  
                    String docID = snapshot.data.documents[i].documentID;
                    String value1 =snapshot.data.documents[i].data['value1'];
                    String value2 = snapshot.data.documents[i].data['value2'];
                    String value3 = snapshot.data.documents[i].data['value3'];
                    String value4 = snapshot.data.documents[i].data['value4'];
                    String carimage =
                        snapshot.data.documents[i].data['urls'][0];                  
                    hotdealobjectlist.add(CarModel(value1,value2,value3,value4,carimage,docID));
                  
                  
                  
                }
                return sliverGridWidget(context); 
              }else{
                return Text("loading");
              }
                 
                 
              },
          ),
        ],
      ),
      
    );
  }
}