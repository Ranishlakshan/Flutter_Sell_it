import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';

class SearchHere extends StatefulWidget {
  @override
  _SearchHereState createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  String carBand;
  String carYear;
  String carImage;
  String docID;

  CarModel carObjec = new CarModel("", "", "", "");

  List<CarModel> _listOfObjects = <CarModel>[];

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

  String searchValue;
  String pressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your Brand Details',
            labelText: 'Brand',
          ),
          onChanged: (value) {
            searchValue = value;
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                pressed = "A";
              });
            },
            child: Text(
              "Search",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
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

                  String carBrand,caryear,carimage,docID;

                  if (serchText.contains(searchValue)) {
                    docID = snapshot.data.documents[i].documentID;
                    carBrand = snapshot.data.documents[i].data['brand'];
                    caryear = snapshot.data.documents[i].data['model'];
                    carimage = snapshot.data.documents[i].data['urls'][0];

                    _listOfObjects.add(CarModel(carBrand, caryear, carimage, docID));
                  }
                }
                return sliverGridWidget(context);
              } else {
                return Text("loading");
              }
            },
          );
    }else{
      return Text('ranish');
    }
    
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