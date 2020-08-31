import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';


import '../itemview.dart';
import 'car_itm_model.dart';



class AadCardForGrid extends StatelessWidget {

  AadCardForGrid(this.ad);
  String documentid;
  CarModel ad;

  //var name1;

  //String name1 = ad.docID.toString();
  Widget _buildImageWidget() {
    //documentid = ad.docID;
    if (ad.carimage != null && ad.carimage != '') {
      //return Image.network(ad.carimage);
      return Stack(
        children: <Widget>[
          Image.network(ad.carimage),
          //Center(child: Text(ad.value2,textDirection: ,),)
          Card(
            child: Text("Rs "+ad.value2),
            color: Colors.yellow,
            
          ),
        ],
      );
    } else {
      return Image.network('https://uae.microless.com/cdn/no_image.jpg');
    }
    
  }
  Widget _buildTitleWidget() {

    if (ad.value1 != null && ad.value1 != '') {
      return Text(ad.value1, style: TextStyle(fontWeight: FontWeight.bold),);
    } else {
      return SizedBox();
    }
  }

  Widget _buildPriceWidget() {
    if (ad.value2 != null && ad.value2 != '') {
      return Text("\$ ${ad.value2}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildLocationWidget() {
    if (ad.value3 != null && ad.value3 != '') {
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(width: 4.0,),
          Expanded(child: Text(ad.value3))
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //'/itemview'
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemView(docID123: ad.docID)));
      },
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImageWidget(),
          _buildTitleWidget(),
          _buildPriceWidget(),
          _buildLocationWidget(),
        ],
      ),
    )
    );
  }
}