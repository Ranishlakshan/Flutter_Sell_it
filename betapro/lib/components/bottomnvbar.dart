import 'package:flutter/material.dart';

class BottomNvBar extends StatefulWidget {
  @override
  _BottomNvBarState createState() => _BottomNvBarState();
}

class _BottomNvBarState extends State<BottomNvBar> {
  int selectedindex=6;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
        buildNavBarIte(Icons.home,0,"/aliexpresspg"),
        buildNavBarIte(Icons.search,1,"/searchtest"),
        buildNavBarIte(Icons.favorite,2,"/hotdeals"),
        buildNavBarIte(Icons.category,3,"/catago"),
        buildNavBarIte(Icons.add_circle,4,"/login"),
        
      ],
    );
  }

  Widget buildNavBarIte(IconData icon,int index,String route) {
    return GestureDetector(
          onTap: (){
            setState(() {
              selectedindex=index;              
            });
            Navigator.popAndPushNamed(context, route);
          },
          child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width/5,
          decoration: BoxDecoration(
            //color: Colors.white
            color: index==selectedindex ? Colors.green : Colors.white
          ),
          child: Icon(icon),
          
        ),
    );
  }
}