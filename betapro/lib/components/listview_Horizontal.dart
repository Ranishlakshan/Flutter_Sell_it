import 'package:flutter/material.dart';
import '';

class MainListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        shrinkWrap : true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Hot Deals')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/hotdeals");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/catago");
            },
          ),

          
          //InkWell(
          //  child: Listitmes(
          //    image_location: 'images/listview/catagory.png',
          //    image_caption: 'ranish',  
          //  ),
          //  onTap: (){
          //    Navigator.pushNamed(context, "/catago");
          //  },
          //),
          
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //  
          //   
          //),
          ////edited up here
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //  
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Hot Deals',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Bid here',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //
          //
          

        ],
      ),
    );
  }
}

//class Listitmes extends StatelessWidget {
//  final String image_location;
//  final String image_caption;
//
//  
//  Listitmes({
//    this.image_location,
//    this.image_caption
//
//    
//  });
//
//  
//  @override
//  Widget build(BuildContext context) {
//    return Padding(padding: const EdgeInsets.all(2.0),
//    child: InkWell(onTap: (){},
//    child: Container(
//          width: 90.0,
//          child: ListTile(
//        title: Image.asset(
//          image_location,
//          width: 50.0,
//          height: 50.0,
//          ),
//        subtitle: Container(
//          alignment: Alignment.topCenter,
//          child: Text(image_caption),
//        ),
//      ),
//    ),
//    ),
//      
//    );
//  }
//}
//
