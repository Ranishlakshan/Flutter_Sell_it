
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'catagories/vehicles/car.dart';
import 'services/crud.dart';

class ImageTest extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const ImageTest({Key key, this.globalKey}) : super(key: key);

  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  var selectedCurrency1, selectedCurrency2, selectedType;
  final _formKeyVan = GlobalKey<FormState>();
  crudMedthods crudObj = new crudMedthods();

  String carBrand;
  String carModel;
  String carYear;
  String carTransmission;

  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;

  var carosal;
  var cars = Firestore.instance.collection("catagory_names").snapshots();

  List<DropdownMenuItem> currencyItems2 = [];

  var disabledropdown = false;

  void firstselected(_value) {
    StreamBuilder(
        stream: cars,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Text("Loading.....");
          else {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              DocumentSnapshot snap = snapshot.data.documents[i];
              if (snap.documentID == selectedCurrency1) {
                for (int j = 0; j < snap.data.length; j++) {
                  currencyItems2.add(
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
          }
        });

    setState(() {
      selectedCurrency1 = _value;
      disabledropdown = true;
    });
  }

  void secondselected(_value) {
    setState(() {
      selectedCurrency2 = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("image upload"),
      ),
      //drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Text("data"),
          SizedBox(height: 40.0),
          StreamBuilder<QuerySnapshot>(
              stream: cars,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Text("Loading.....");
                else {
                  List<DropdownMenuItem> currencyItems = [];
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    currencyItems.add(
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
                        items: currencyItems,
                        onChanged: (currencyValue) {
                          setState(() {
                            selectedCurrency1 = currencyValue;
                            //disabledropdown = true;
                          });
                          for (int i = 0;
                              i < snapshot.data.documents.length;
                              i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            if (snap.documentID == selectedCurrency1) {
                              for (int j = 0; j < snap.data.length; j++) {
                                currencyItems2.add(
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
                              'Selected Currency value is $currencyValue',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        value: selectedCurrency1,
                        isExpanded: false,
                        hint: new Text(
                          "Choose Category Type",
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                      ),
                      DropdownButton(
                        items: currencyItems2,
                        onChanged: (currencyValue) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected Currency value is $currencyValue',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            selectedCurrency2 = currencyValue;
                          });
                        },
                      ),
                    ],
                  );
                }
              }),
          _widgetForm(),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('Card tapped.');
              },
              child: Container(
                width: 300,
                height: 100,
                child: Text('A card that can be tapped'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetForm() {

    switch (selectedCurrency2) {
      case "car":
        return carForm();
        break;
      // case "Van":
      //   return _vanForm();
      //   break;
      default:
        return Text(' ');
        break;
    }
  }
  //upload data into firebase and database
  void uploadDetails() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance
              .collection('testcrud')
              .document(documnetID)
              .setData({
            'carBrand': carBrand,
            'carModel': carModel,
            'carYear': carYear,
            'carTransmission': carTransmission,
            'urls': imageUrls,
          }).then((_) {
            // SnackBar snackbar =
            //   SnackBar(content: Text('Uploaded Successfully'));
            // widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
              carosal = "B";
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

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

    setState(() {
      carosal = "A";
    });

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Widget _imageShow() {
    if (carosal == "A") {
      return CarouselSlider(
          items: images
              .map((e) => AssetThumb(asset: e, width: 300, height: 300))
              .toList(),
          options: CarouselOptions(
            height: 400,
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
    } else {
      return Text("data");
    }
  }
}
