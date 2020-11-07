import 'package:betapro/components/locationclass.dart';
import 'package:betapro/components/locationwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../login_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

class busForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const busForm({Key key, this.globalKey}) : super(key: key);
  @override
  _busFormState createState() => _busFormState();
}

class _busFormState extends State<busForm> {
  
  final _formKeyBus = GlobalKey<FormState>();
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool carosal = false;

  String carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,
  carDescription,carPrice,carCondition,phonenumbers,location,carColor;
  String searchkey;

  var location1 = Firestore.instance.collection("location").snapshots();
  var location1selected,location2selected;
  List<DropdownMenuItem> locationlist2 = [];

  Locationclass loccz = Locationclass();
  
  var _transmissionType = [
    "Auto",
    "Manual",
    "Triptonic",
  ];

  var _carFuelType = [
    "Petrol",
    "Diesel",
    "Hybrid",
    "Electric"
  ];

  var _carCondition = [
    "Brand new",
    "Used",
    "Recondition",
  ];

  
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
      return Text('Images not yet selected');
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
          //List list123 = 
          String testLocation = '${loccz.getTownname()},${loccz.getdistrictName()}';
          print(testLocation);
          //carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition
          Firestore.instance.collection('ads').document(documnetID).setData({
            'urls':imageUrls,
            'brand':carBrand,
            'model':carModel,
            'year':carYear,
            'price':carPrice,
            'milleage':carMilleage,
            'transmission':carTransmission,
            'fuelType':carFuelType,
            'engineCapacity':carEngineCapacity,
            'condition':carCondition,
            'description':carDescription,
            'phone': phonenumbers,
            'location': testLocation,
            'reviewstatus':false,  
            'searchkey':carBrand+" "+carModel+" "+carYear+"busesBuses",
            'value1':carBrand+" "+carModel+" "+carYear,
            'value2':carPrice,
            'value3':testLocation,
            'value4':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
            //
            'category':"buses,vehicles",
            

          }).then((_){
            
            SnackBar snackbar = SnackBar(content: Text('Data Uploaded Successfully'));
            widget.globalKey.currentState.showSnackBar(snackbar);
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
    final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true,);
    pr.style(
      message: 'Uploading Data',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      //textDirection: TextDirection.rtl,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return Card(
      child: Form(
        
        key: _formKeyBus,
        child: Column(children: <Widget>[
          
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
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Brand',
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
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Model',
              labelText: 'Model',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          
          
          
          TextFormField(
            keyboardType: TextInputType.number,
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
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Model year',
              labelText: 'Model Year',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          
          
          
          TextFormField(
            keyboardType: TextInputType.number,
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
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Mileage',
              labelText: 'Mileage ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          
          
          
          FormField<String>(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please Select Transmission';
              }
              return null;
            },
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              
              decoration: const InputDecoration(
              //hintText: 'Enter Transmission Type',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              //hintText: 'Enter Transmission Type',
              labelText: 'transmission',
              prefixIcon: Icon(Icons.add_circle)
            ),
                  
              isEmpty: carTransmission == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  
                  value: carTransmission,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      carTransmission = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _transmissionType.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
          SizedBox(height: 20.0),
          
          
          
          FormField<String>(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please Select Fuel Type';
              }
              return null;
            },
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              
              decoration: const InputDecoration(
              //hintText: 'Enter Transmission Type',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Fuel Type',
              labelText: 'Fuel Type',
              prefixIcon: Icon(Icons.add_circle)
            ),
                  
              isEmpty: carFuelType == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  
                  value: carFuelType,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      carFuelType = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _carFuelType.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
          SizedBox(height: 20.0),
          
          
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged:  (value) {
                 carEngineCapacity=value;         
                        },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Engine capaciy';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Engine capacity',
              labelText: 'Engine capacity(cc) ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          
          
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 15,
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
              border: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.black)
               ),
              hintText: 'Enter Description here',
              labelText: 'Description ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0),
          //carCondition
          
          
          
          FormField<String>(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please Select Car Condition';
              }
              return null;
            },
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              
              decoration: const InputDecoration(
              //hintText: 'Enter Transmission Type',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Select car Condition',
              labelText: 'Condition',
              prefixIcon: Icon(Icons.add_circle)
            ),
                  
              isEmpty: carCondition == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  
                  value: carCondition,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      carCondition = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _carCondition.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
        
               
          SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
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
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Price here',
              labelText: 'Price ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          
          //SizedBox(height: 20.0),
          //RaisedButton(
          //  child: new Text("add Image"),
          //  onPressed: loadAssets,
          //),
          //SizedBox(height: 10.0,),
          SizedBox(height: 20.0),
          RaisedButton.icon(
            icon: Icon(Icons.add_a_photo),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.green,
            padding: EdgeInsets.all(10.0),
            label: Text('add photos'),
            //child: new Text("add Image"),
            onPressed: loadAssets,
          ),
          SizedBox(height: 10.0,),
          _imageShow(),
          
          SizedBox(height: 20.0),
          //Text("Posted by $name"),
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage("$imageUrl"),
              ),
              SizedBox(width: 30.0,),
              Text("Posted by $name"),
              //Text(),
              
            ],
          ),
          SizedBox(height: 20.0),
          Text('Email -> $email'),
          SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.phone,
            onChanged:  (value) {
                 phonenumbers = value;         
                        },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Phone number';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              hintText: 'Enter Phone number here',
              labelText: 'Phone number ',
              prefixIcon: Icon(Icons.add_circle)
            ),
          ),
          SizedBox(height: 20.0,),
          
          
          
          
          ///
          ///
          ///
          LocationAdd(locationDetails: loccz),
          

          //
          //
          SizedBox(height: 20.0),
          RaisedButton(

              color: Color(0xff11b719),
              textColor: Colors.white,
              child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Submit", style: TextStyle(fontSize: 24.0)),
                ],
              )
              ),
              onPressed: () {
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
                  uploadImages();
                  Navigator.pushReplacementNamed(context, "/uploadwait");
                }
              
              },
              
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  
                )
              ),
              SizedBox(height: 20.0),
              
              
        ]
        )
        )
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}