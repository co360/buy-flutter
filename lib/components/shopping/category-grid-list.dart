import 'package:flutter/material.dart';
import 'package:storeFlutter/components/button/grid-button.dart';

class CategoryGridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10.0, left: 20.0),
            child: Text(
              "Title",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Column(children: _generateDynamicList()),
        ],
      ),
    );
  }

  List<Widget> _generateDynamicList() {
    List<Widget> list = List();
    for (int i = 0; i < 5; i++) {
      list.add(Container(
          margin: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GridButton(
                  title: "test1",
                  cb: () {
                    print("Select test1");
                  }),
              GridButton(
                  title: "test2",
                  cb: () {
                    print("Select test2");
                  }),
              GridButton(
                  title: "test3",
                  cb: () {
                    print("Select test3");
                  }),
            ],
          )));
    }
    return list;
  }
}
