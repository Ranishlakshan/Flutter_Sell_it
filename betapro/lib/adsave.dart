import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveAdvertisement extends StatefulWidget {
  static const String routeName = "/second";
  @override
  _SaveAdvertisementState createState() => _SaveAdvertisementState();
}

class _SaveAdvertisementState extends State<SaveAdvertisement> {
  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  final _formKeyCar = GlobalKey<FormState>();
  final _formKeyVan = GlobalKey<FormState>();

  List<String> _accountType = <String>[
    'Savings',
    'Deposit',
    'Checking',
    'Brokerage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text("Account Details",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
        body: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              new TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Phone Details',
                    labelText: 'Phone',
                  ),
                  keyboardType: TextInputType.number),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your Name',
                  labelText: 'Name',
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your Email Address',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 50.0),
                  DropdownButton(
                    items: _accountType
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (selectedAccountType) {
                      print('$selectedAccountType');
                      setState(() {
                        selectedType = selectedAccountType;
                      });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text(
                      'Choose Account Type',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection("catagory_names").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        for (int j = 0; j < snap.data.length; j++) {
                          currencyItems.add(
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected Currency value is $currencyValue',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Currency Type",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 150.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ),
              _widgetForm(),
            ],
          ),
        ));
  }
  Widget _widgetForm() {
    // if (selectedCurrency == "Car") {
    //   return Form(
    //       key: _formKeyCar,
    //       child: Column(children: <Widget>[
    //         // Add TextFormFields and RaisedButton here.
    //         TextFormField(
    //           validator: (value) {
    //             if (value.isEmpty) {
    //               return 'Please enter some text';
    //             }
    //             return null;
    //           },
    //         ),
    //       ]));
    // }

    switch (selectedCurrency) {
      case "Car":
        return _carForm();
        break;
      case "Van":
        return _vanForm();
        break;
    }
  }

  Widget _carForm() {
    return Form(
        key: _formKeyVan,
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
              hintText: 'Enter your Car Details',
              labelText: 'Car',
            ),
          ),
        ]));
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
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your Van Details',
              labelText: 'Van',
            ),
          ),
        ]));
  }
}