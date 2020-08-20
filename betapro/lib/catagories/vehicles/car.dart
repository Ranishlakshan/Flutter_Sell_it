import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../aditem.dart';

class carForm extends StatefulWidget {
  @override
  _carFormState createState() => _carFormState();
}

class _carFormState extends State<carForm> {
  
  //bool carosal;
  final _formKeyCar = GlobalKey<FormState>();
  final _formKeyVan = GlobalKey<FormState>();
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool carosal = false;

  String carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition;

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
 

  void uploadImages(){
  
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if(imageUrls.length==images.length){
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          //carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition
          Firestore.instance.collection('ads').document(documnetID).setData({
            'urls':imageUrls,
            'brand':carBrand,
            'model':carModel,
            'year':carYear,
            'price':carPrice,
            'milleage':carMilleage,
            'transmission':carTransmission,
            'FuelType':carFuelType,
            'EngineCapacity':carEngineCapacity,
            'condition':carCondition,
            'description':carDescription,
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


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        
        key: _formKeyCar,
        child: Column(children: <Widget>[
          // Add TextFormFields and RaisedButton here.
          //buildGridView(),
          TextFormField(
            onChanged:  (value) {
                 carBrand=value;         
                        },
            validator: (String value) {
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
            onChanged:  (value) {
                 carModel=value;         
                        },
            validator: (String value) {
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
            onChanged:  (value) {
                 carYear=value;         
                        },
            validator: (String value) {
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
            onChanged:  (value) {
                 carMilleage=value;         
                        },
            validator: (String value) {
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
            onChanged:  (value) {
                 carTransmission=value;         
                        },
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
            onChanged:  (value) {
                 carFuelType=value;         
                        },
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
            onChanged:  (value) {
                 carEngineCapacity=value;         
                        },
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
            onChanged:  (value) {
                 carDescription=value;         
                        },
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
          //carCondition
          TextFormField(
            onChanged:  (value) {
                 carCondition=value;         
                        },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter condition';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter condition here',
              labelText: 'Condition ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          
          SizedBox(height: 20.0),
          TextFormField(
            onChanged:  (value) {
                 carPrice=value;         
                        },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Price';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter Price here',
              labelText: 'Price ',
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
                  //createRecord();
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
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                )
              ),
              
              
        ]
        )
        )
    );
  }
}