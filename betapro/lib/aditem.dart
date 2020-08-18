import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'services/utils.dart';



class AdAdvertisement extends StatefulWidget {
  @override
  _AdAdvertisementState createState() => _AdAdvertisementState();
}

class _AdAdvertisementState extends State<AdAdvertisement> {
  var selectedCurrency,selectedSub;
  var value;
  final databaseReference = Firestore.instance;
  String now = new DateTime.now().toString();
  List<Asset> images = List<Asset>();
  //List<NetworkImage> _listOfImages = <NetworkImage>[];
  List<String> imageUrls = <String>[];
  //List<String> imageLocalLink = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;
  bool carosal = false;


  final _formKeyCar = GlobalKey<FormState>();
  final _formKeyVan = GlobalKey<FormState>();
  
  void ValueChanged(currencyValue){
    setState(() {
          selectedCurrency =currencyValue;
        });
  }

  void ValueSubchange(subcatagory){
    setState(() {
          selectedSub=subcatagory;
        });
  }

  void createRecord() async {
    await databaseReference.collection("Advertisements")
        .document(now)
        .setData({
          'title': 'Mastering Flutter',
          'description': 'Programming Guide for Dart'
        });

    
  }

  Widget _widgetForm() {
    switch (selectedSub) {
      case "car":
        return _carForm();
        break;
      case "van":
        return _vanForm();
        break;
    }
  }
  //
  
  //

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));

    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      carosal = true;
      print('<<<<<<<<<<<<<<<<<<<');
      print(images);
      
      
      //_listOfImages = imageUrls.cast<NetworkImage>();
      _error = error;
    });
  }
  Widget _imageShow(){
    if(carosal==true){
      return CarouselSlider(
        items: images
        .map((e) => AssetThumb(asset:e, width: 300, height: 300,))
        .toList(),
        options: CarouselOptions(
          height: 400,
          aspectRatio: 16 /9 ,
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

        ),  
      );
    }
    else{
      return Text('not yet selected');
    }
  }

  void uploadImages(){
  
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if(imageUrls.length==images.length){
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance.collection('images').document(documnetID).setData({
            'urls':imageUrls
          }).then((_){
            SnackBar snackbar = SnackBar(content: Text('Uploaded Successfully'));
            //widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
              carosal =false;
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Widget _carForm() {
    return Card(
      child: Form(
        
        key: _formKeyVan,
        child: Column(children: <Widget>[
          // Add TextFormFields and RaisedButton here.
          //buildGridView(),
          TextFormField(
             
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Brand';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your Car Brand',
              labelText: 'Brand',
              prefixIcon: Icon(Icons.add_circle) 
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Model';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your Car Model',
              labelText: 'Car Model',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Model Year';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Car Model year',
              labelText: 'Model Year',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Mileage';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Mileage',
              labelText: 'Mileage ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter Transmission type';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Transmission type',
              labelText: 'Transmission ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Fueltype';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Fuel type',
              labelText: 'Fueltype ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Engine capaciy';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Engine capacity',
              labelText: 'Engine capacity(cc) ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Description';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Description here',
              labelText: 'Description ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Price';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Price',
              labelText: 'Price',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            child: new Text("add Image"),
            onPressed: loadAssets,
          ),
          SizedBox(height: 10.0,),
          _imageShow(),
          
          RaisedButton(
              child: new Text("upload"),
              onPressed: (){
                if(images.length==0){
                  showDialog(context: context,builder: (_){
                    return AlertDialog(
                      backgroundColor: Theme.of(context).backgroundColor,
                     content: Text("No image selected",style: TextStyle(color: Colors.white)),
                     actions: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Center(child: Text("Ok",style: TextStyle(color: Colors.white),)),
                      )
                      
                     ],
                    );
                  });
                }
                else{
                  SnackBar snackbar = SnackBar(content: Text('Please wait, we are uploading'));
                  //widget.globalKey.currentState.showSnackBar(snackbar);
                  uploadImages();
                }
              },
          ),
          SizedBox(height: 20.0),
          RaisedButton(
              color: Color(0xff11b719),
              textColor: Colors.white,
              child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Submit", style: TextStyle(fontSize: 24.0)),
                ],
              )),
              onPressed: () {
                  createRecord();
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                )
              ),
              
              
        ]
        )
        )
    );
  }

  Widget _vanForm() {
    return Form(
        key: _formKeyCar,
        child: Column(children: <Widget>[
          // Add TextFormFields and RaisedButton here.
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your Van Model',
              labelText: 'Model',
            ),
          ),
          
        ]));
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
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        if(snap.documentID==selectedCurrency){
                            for (int j = 0; j < snap.data.length; j++) {
                          currencySub.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.data['${j + 1}'].toString(),
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: snap.data['${j + 1}'].toString(),
                            ),
                          );
                        }
                        }
                        
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) => ValueChanged(currencyValue), 
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Choose catagory Type",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                          DropdownButton(
                            items: currencySub,
                            onChanged: (subcatagory) => ValueSubchange(subcatagory), 
                            value: selectedSub,
                            isExpanded: false,
                            hint: new Text(
                              "Choose sub",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                      
                    }
                  }),
                  
              _widgetForm(),
            
              
          ],
        ),
    );
  }
}