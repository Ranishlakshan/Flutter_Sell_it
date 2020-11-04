import 'package:flutter/material.dart';

import 'login_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("$name"),
              accountEmail: Text("$email"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("$imageUrl"),
              ),
            ),
            //aliexpresspg
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/aliexpresspg');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.home),
                    SizedBox(width: 20,),
                    Text("HomePage", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/hotdeals');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.favorite),
                    SizedBox(width: 20,),
                    Text("Hot Deals", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.add_shopping_cart),
                    SizedBox(width: 20,),
                    Text("Post a AD", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/catago');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.category),
                    SizedBox(width: 20,),
                    Text("Categories", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.input),
                    SizedBox(width: 20,),
                    Text("Log In", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            
            
            //ListTile(
            //  title: Text('Post a AD'),
            //    
            //  onTap: () {
            //    // Update the state of the app
            //    // ...
            //    //Navigator.pushNamed(context, '/login');
            //    // Then close the drawer
            //    Navigator.pop(context);
            //  },
            //),
            
            
          ],
        ),
      );
  }
}