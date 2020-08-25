import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CarModel {
  String carBrand;
  String caryear;
  String carimage;
  String docID;

  CarModel(String carBrand, String caryear, String carimage ,String docID){
    this.carBrand = carBrand;
    this.caryear = caryear;
    this.carimage = carimage;
    this.docID = docID;
  }

  //CarModel.fromJson(Map<String, dynamic> json) {
  //  carBrand = json['userId'];
  //  caryear = json['id'];
  //  carimage = json['title'];
  //}

  getData() async {
    return await Firestore.instance.collection('ads').snapshots();
  }

void setcarBrand(String carBrand){
this.carBrand = carBrand;
}

void setcarYear(String carYear){
this.carBrand = carYear;
}

void setcarImage(String carImage){
this.carBrand = carBrand;
}

void setdocID(String docID){
  this.docID = docID;
}

String getBrand(){
  return carBrand;
}
String getYear(){
  return caryear;
}
String getdocID(){
  return docID;
}

getSearch(String text) async {
    return await Firestore.instance.collection('ads').where('brand',isGreaterThanOrEqualTo: text).snapshots();
  }


}
