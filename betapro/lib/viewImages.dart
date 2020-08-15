import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewImages extends StatelessWidget {
  List<NetworkImage> _listOfImages = <NetworkImage>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('images').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          _listOfImages = [];
                          for (int i = 0;
                              i <
                                  snapshot.data.documents[index].data['urls']
                                      .length;
                              i++) {
                            _listOfImages.add(NetworkImage(snapshot
                                .data.documents[index].data['urls'][i]));
                          }
                          return Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10.0),
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Carousel(
                                    boxFit: BoxFit.cover,
                                    images: _listOfImages,
                                    autoplay: false,
                                    indicatorBgPadding: 5.0,
                                    dotPosition: DotPosition.bottomCenter,
                                    animationCurve: Curves.fastOutSlowIn,
                                    animationDuration:
                                        Duration(milliseconds: 2000)),
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.red,
                              )
                            ],
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
                )
      ],
    );
  }
}