import 'package:flutter/material.dart';

Widget vanForm() {
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
            decoration: const InputDecoration(
              hintText: 'Enter your Van Model',
              labelText: 'Model',
            ),
          ),
          
        ]));
  }