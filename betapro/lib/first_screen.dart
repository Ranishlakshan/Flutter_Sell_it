import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'login_page.dart';



class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: Image.network(imageUrl),
            onPressed: (){},   
           )
        ],
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
         stream: Firestore.instance.collection('items').snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData) return Text('Loading data..please wait');
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text(snapshot.data.documents[0]['item_name']),
               Text(snapshot.data.documents[0]['price'].toString())
               
             ],
           );
         }, 
      )
    );
  }
}
