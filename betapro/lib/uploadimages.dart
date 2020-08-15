import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'services/crud.dart';
import 'services/utils.dart';


class UploadImages extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const UploadImages({Key key, this.globalKey}) : super(key: key);
  @override
  _UploadImagesState createState() => new _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  var Select_catagory;
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;
  
  //String condition="";
  List<DropdownMenuItem> items = <DropdownMenuItem>[];
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ThreeDContainer(
            backgroundColor: MultiPickerApp.darker,
            backgroundDarkerColor: MultiPickerApp.darker,
            height: 50,
            width: 50,
            borderDarkerColor: MultiPickerApp.pauseButton,
            borderColor: MultiPickerApp.pauseButtonDarker,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //

        Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: new Text("add record"),
                  onPressed: (){
                    getData();
                  },
                ),
                
                //Stream builder///////////////////////////
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("catagory_names").snapshots(),
                  builder: (context,snapshot){
                    //snapshot.data.documents.forEach((f) => print('${f.data}}'));
                    //print('${snapshot.data.documents[1].data.values}');
                    if(!snapshot.hasData){
                      Text("Loading");
                    }
                    else{
                      List<DropdownMenuItem> catagories = [];
                      //snapshot.documents.forEach((f) => print('${f.data}}'));
                      for(int i=0;i<snapshot.data.documents.length;i++){
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        
                        catagories.add(
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
                          SizedBox(width: 50.0,),
                          DropdownButton(
                            items: catagories,
                            onChanged: (catagoryValue){
                              ////
                              //choose();

                              
                              final snackBar=SnackBar(
                                content: Text('Selected Catagory is $catagoryValue'),
                                
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                  //condition = "A";
                                  Select_catagory=catagoryValue;                                                              
                              });
                            },
                          value: Select_catagory,
                          isExpanded: false,
                          hint: Text('choose catagory'),  
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: new Text("add Image"),
                      onPressed: loadAssets,
                    ),
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
                          widget.globalKey.currentState.showSnackBar(snackbar);
                          uploadImages();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: buildGridView(),
                )
              ],
            ),
          ),
          //MyCustomForm(),
          _widgetForm(),
      ],
    );
  }
//Widget _
Widget _widgetForm() {
          switch (Select_catagory) {
      case "Animals":
        return MyCustomForm();
        break;
      case "Vehicles":
        return _vanForm();
        break;
      default :
        return Form(
          child: Text('data'),
        );
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
            widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }
  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  //////////////////
  Future getCatagory() async {
      var firestone = Firestore.instance;

      QuerySnapshot cato = await firestone.collection("catagory_names/Vehicles").getDocuments();
      for(int i=0;i<cato.documents.length;i++){
                        DocumentSnapshot snap = cato.documents[i];
                        items.add(
                          DropdownMenuItem(
                            child: Text(
                                snap.documentID,
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }

      return ;

    }
    ///////////
    ///
    ///
    ///
    void createRecord() async {
    await databaseReference.collection("books")
        .document("1")
        .setData({
          'title': 'Mastering Flutter',
          'description': 'Programming Guide for Dart'
        });

    DocumentReference ref = await databaseReference.collection("books")
        .add({
          'title': 'Flutter in Action',
          'description': 'Complete Programming Guide to learn Flutter'
        });
    print(ref.documentID);
  }

  void getData() {
    databaseReference
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
  void updateData() {
    try {
      databaseReference
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }
  void deleteData() {
    try {
      databaseReference
          .collection('books')
          .document('1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
    ///
}

Widget _vanForm() {
    return Form(
        //key: _formKeyCar,
        child: Column(children: <Widget>[
          // Add TextFormFields and RaisedButton here.
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your Van Details',
              labelText: 'Van',
            ),
          ),
        ]));
  }


class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  crudMedthods crudObj = new crudMedthods();
  String carModel;
  String carColor;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter car model'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              this.carModel = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter car color'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              this.carColor = value;
            },
          ),
          //end of the text fields

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {

                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  Navigator.of(context);
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                  String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
                  Firestore.instance.collection('data').document(documnetID).setData({
                    'carname' : this.carModel,
                    'carColor': this.carColor
                  }).then((_){
                    SnackBar snackbar = SnackBar(content: Text('Uploaded Successfully'));
                    Scaffold.of(context).showSnackBar(snackbar); 
                  });    
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}


Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  //Navigator.of(context).pop();first_screen
                  Navigator.pushNamed(context, '/first_screen');
                },
              )
            ],
          );
        });
  }
