///NO USAGE AT NOW

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'services/crud.dart';
//import 'login_page.dart';


class FirstScreen extends StatelessWidget {
  
  QuerySnapshot cars;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.pushNamed(context, '/searchitem');
            },
          ),
          IconButton(
            icon: Icon(Icons.tap_and_play),
            onPressed: (){
              Navigator.pushNamed(context, '/dashboard');
            },   
          ),
          IconButton(
            icon: Icon(Icons.add_call),
            onPressed: (){
              
            },   
           ),
           IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: (){
              //Navigator.pushNamed(context, '/admobdoc');
           Navigator.pushNamed(context, '/admobpg');
            },   
           )
        ],
      ),
      drawer: MyDrawer(),
      body: MyCustomForm(),
    );
  }
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
