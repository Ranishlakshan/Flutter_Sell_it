import 'package:flutter/material.dart';

class MainListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        shrinkWrap : true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Hot Deals',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Bid here',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          Listitmes(
            image_location: 'images/listview/catagory.png',
            image_caption: 'Catagories',
          ),
          
          
          

        ],
      ),
    );
  }
}

class Listitmes extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Listitmes({
    this.image_location,
    this.image_caption
  });

  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(onTap: (){},
    child: Container(
          width: 90.0,
          child: ListTile(
        title: Image.asset(
          image_location,
          width: 50.0,
          height: 50.0,
          ),
        subtitle: Container(
          alignment: Alignment.topCenter,
          child: Text(image_caption),
        ),
      ),
    ),
    ),
      
    );
  }
}

