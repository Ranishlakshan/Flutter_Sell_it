import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'catagories/electronics/electronic.dart';
import 'catagories/electronics/electronicsaccessories.dart';
import 'catagories/essentials/essentials.dart';
import 'catagories/hobby,sports,kids/hobbysportskids.dart';
import 'catagories/homeandgarden/homeandgarden.dart';
import 'catagories/industry/industrytools.dart';
import 'catagories/industry/officeequipment.dart';
import 'catagories/industry/other.dart';
import 'catagories/industry/solarGenerators.dart';
import 'catagories/jobs/jobs.dart';
import 'catagories/property/apartments.dart';
import 'catagories/property/commercialproperty.dart';
import 'catagories/property/holydayShortTerm.dart';
import 'catagories/property/houses.dart';
import 'catagories/property/land.dart';
import 'catagories/property/roomsanex.dart';
import 'catagories/vehicles/autoparts.dart';
import 'catagories/vehicles/autoservises.dart';
import 'catagories/vehicles/bicycle.dart';
import 'catagories/vehicles/bike.dart';
import 'catagories/vehicles/boat.dart';
import 'catagories/vehicles/bus.dart';
import 'catagories/vehicles/car.dart';
import 'catagories/vehicles/lorry.dart';
import 'catagories/vehicles/rentAcar.dart';
import 'catagories/vehicles/threeWheels.dart';
import 'catagories/vehicles/tractors.dart';
import 'catagories/vehicles/van.dart';

import 'components/bottomnvbar.dart';
import 'drawer.dart';
import 'login_page.dart';
import 'services/utils.dart';



class AdAdvertisement extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const AdAdvertisement({Key key, this.globalKey}) : super(key: key);
  @override
  _AdAdvertisementState createState() => _AdAdvertisementState();
}

class _AdAdvertisementState extends State<AdAdvertisement> {
  var selectedCurrency,selectedSub;
  var  selectedCurrency2, selectedType;
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

  var catagory_names = Firestore.instance.collection("catagory_names").snapshots();
  
  //void ValueChanged(var currencyValue){
  //  setState(() {
  //        selectedCurrency =currencyValue;
  //      });
  //}

  void ValueSubchange(var subcatagory){
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
    switch (selectedCurrency2) {
      //vehicles---------------------------------
      case "Cars":
        return carForm();
        break;
      case "Vans":
        return vanForm();
        break;  
      case "Buses":
        return busForm();
        break;  
      case "Lorries":
        return lorryForm();
        break;  
      case "Three Wheels":
        return threewheelForm();
        break;  
      case "Motorbikes and Scooters":
        return bikeForm();
        break;  
      case "Boats and Water Transport":
        return boatForm();
        break;  
      case "Heavy Machinery & Tractors":
        return tractorsForm();
        break;
      case "Bicycles":
        return bicycleForm();
        break;
      case "Auto Parts & Accessories":
        return autopartsForm();
        break;
      case "Auto Services":
        return autoServiceForm();
        break;
      case "Rent A Car":
        return rentACarForm();
        break;
      //Property--------------------------
      case "Houses":
        return houseForm();
        break;  
      case "Lands":
        return landForm();
        break;
      case "Apartments":
        return apartmentsForm();
        break; 
      case "Commercial Property":
        return commercialPropertyForm();
        break;
      case "Rooms & Annexes":
        return roomanexForm();
        break;
      case "Holiday & Short-Term Rental":
        return holidatShortTermForm();
        break; 
      //Industry tools and machines---------------------------
      case "Industry Tools Machinary":
        return industryToolForm();
        break;
      case "Office Equipment, Supplies & Stationery":
        return officetoolsForm();
        break;
      //solarForm
      case "Solar and Generators":
        return solarForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Other Business  Services":
        return otherBusinessForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Row Materials Wholesale Items":
        return otherBusinessForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Health Care":
        return otherBusinessForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Licesnces /permits":
        return otherBusinessForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      //Hobby,Sports,Kids--------------------------
      case "Musical Instruments":
        return hobbySportsKidsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Sports & Fitness":
        return hobbySportsKidsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Art & Collectibles":
        return hobbySportsKidsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Children's Items":
        return hobbySportsKidsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Other Hobby, Sport & Kids Items":
        return hobbySportsKidsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Music, Books & Movies":
        return hobbySportsKidsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      //Essentials -------------------------------
      case "Healthcare":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Grocery":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Fruits & Vegetables":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Baby Products":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Other Essentials":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Household":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Meat & Seafood":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Gas":
        return essentialsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
        //Jobs ---------------------------------
      case "Banking and Financials":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Logistics and Transport":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Hotel and Travel":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Education":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Sales and Distribution":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Constructions":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Electronics":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Automobiles":
        return jobsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;  

      //Electronics -------------------------------------
      case "Cell Phones and Smart Phones":
        return electronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Cameras and Camcorders":
        return electronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Computer,Laptops and Tabs":
        return electronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Computer Accessories":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Air Condition and Elecrical Fittings":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Audio and Mp3":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Electronic Home Appliance":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Mobile Phone Accessories":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Video Games and Consoles":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Other Electronics":
        return otherElectronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break; 
      //home And Garden --------------------------------------
      case "Furniture":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Bathroom and Sanitary Ware":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Kitchen Items":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Garden":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Building Matireal and Tool":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Home Decorations":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Other Items":
        return homeAndGardenForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
       

      default:
        return Text(' ');
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

  List<DropdownMenuItem> currencyItems2 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Post Advertisement',style: TextStyle(letterSpacing: 2),),
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
            
            SizedBox(height: 10.0),
            StreamBuilder<QuerySnapshot>(
              stream: catagory_names,
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
                      //SizedBox(width: 20.0),
                      DropdownButton(
                        items: currencyItems,
                        onChanged: (currencyValue) {
                          setState(() {
                            selectedCurrency = currencyValue;
                            //disabledropdown = true;
                          });
                          for (int i = 0;i < snapshot.data.documents.length;i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            if (snap.documentID == selectedCurrency) {
                              currencyItems2 = [];
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
                              'Selected Category is $currencyValue',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        value: selectedCurrency,
                        isExpanded: false,
                        hint: new Text(
                          "Choose Category for Ad",
                          style: TextStyle(color: Color(0xff11b719),letterSpacing: 2),
                        ),
                      ),
                      DropdownButton(
                        items: currencyItems2,
                        onChanged: (currencyValue) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected  Sub Category is $currencyValue',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            selectedCurrency2 = currencyValue;
                            currencyItems2 = [];
                            currencyItems = [];
                          });
                        },
                        hint: new Text(
                          "Choose Sub Category for Ad",
                          style: TextStyle(color: Color(0xff11b719),letterSpacing: 1),
                        ),
                      ),
                    ],
                  );
                }
              }),
          _widgetForm(),
          
                  
              //_widgetForm(),
            
              
          ],
        ),
    );
  }
}