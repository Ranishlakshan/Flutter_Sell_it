import 'package:flutter/material.dart';

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
      return Image.network(ad.carimage);
    } else {
      return Image.network('https://uae.microless.com/cdn/no_image.jpg');
    }
    
  }
  Widget _buildTitleWidget() {

    if (ad.carBrand != null && ad.carBrand != '') {
      return Text(ad.carBrand, style: TextStyle(fontWeight: FontWeight.bold),);
    } else {
      return SizedBox();
    }
  }

  Widget _buildPriceWidget() {
    if (ad.caryear != null && ad.caryear != '') {
      return Text("\$ ${ad.caryear}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildLocationWidget() {
    if (ad.caryear != null && ad.caryear != '') {
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(width: 4.0,),
          Expanded(child: Text(ad.caryear))
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
          // _buildLocationWidget(),
        ],
      ),
    )
    );
  }
}