import 'package:flutter/material.dart';

import 'components/bottomnvbar.dart';

class Uploadpg extends StatefulWidget {
  @override
  _UploadpgState createState() => _UploadpgState();
}

class _UploadpgState extends State<Uploadpg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        title: Text("Uploading Stuff",style: TextStyle( letterSpacing: 2),),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25,),
            Text("Document Uploading..."),
            SizedBox(height: 10,),
            Text('Advertisement is under review and appear soon..'),
            SizedBox(height: 10,),
            Text('data') 
          ],
        ),
      ),
    );
  }
}