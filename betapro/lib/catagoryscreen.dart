
import 'package:flutter/material.dart';
import 'components/catagorylist.dart' as categoriesList;

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      backgroundColor: Colors.white,
      body: categoriesList.list == null
          ? const Center(child: const CircularProgressIndicator())
          : new GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 25.0),
              padding: const EdgeInsets.all(10.0),
              itemCount: categoriesList.list.length,
              itemBuilder: (BuildContext context, int index) {
                return new GridTile(
                  footer: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Flexible(
                          child: new SizedBox(
                            height: 25.0,
                            width: 100.0,
                            child: new Text(
                              categoriesList.list[index]["name"],
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ]),
                  child: Card(
                    child: new Container(
                      height: 500.0,
                      child: new GestureDetector(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: new Row(
                                children: <Widget>[
                                  new Stack(
                                    children: <Widget>[
                                      new SizedBox(
                                        child: new Container(
                                          child: new CircleAvatar(
                                            backgroundColor: categoriesList
                                                .list[index]["color"],
                                            radius: 40.0,
                                            child: Image.asset(
                                              categoriesList.list[index]
                                                  ["icon"],
                                              height: 40.0,
                                              width: 40.0,
                                            ),
                                          ),
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ], 
                        ),
                        onTap: () {
                          //Navigator.push(
                          //  context,
                          //  MaterialPageRoute(
                          //      // builder: (context) =>  categoriesList.list[index]
                          //      //                   ["page"]()),
                          //       builder: (context) => ShowItems()),
                          //);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}