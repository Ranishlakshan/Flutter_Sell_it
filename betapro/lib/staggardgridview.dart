import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
 
 
class MyAppStagger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Ranish(),
    );
  }
}
 
class Ranish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StaggeredGridView.countBuilder(
          shrinkWrap : true,
          crossAxisCount: 4,
          //itemCount: 15,
          itemBuilder: (BuildContext context, int index) => new Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/500/500?random=$index'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
             ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 3 : 2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      );
    
  }
}