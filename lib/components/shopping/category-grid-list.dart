import 'package:flutter/material.dart';
import 'package:storeFlutter/components/button/grid-button.dart';
import 'package:storeFlutter/components/button/grid-button-disable.dart';
import 'package:storeFlutter/models/shopping/category.dart';
import 'package:storeFlutter/models/query-result-category.dart';

class CategoryGridList extends StatelessWidget {
  final Layer2CategoryLists category;

  CategoryGridList(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10.0, left: 20.0),
            child: Text(
              category.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Column(children: _generateDynamicList(category.layer3Category)),
        ],
      ),
    );
  }

  List<Widget> _generateDynamicList(List<Layer3CategoryLists> categories) {
    List<Widget> list = List();
    print("test");
    print(categories);
    if (categories == null) return list;

    for (int i = 1; i < categories.length; i += 2) {
      list.add(Container(
          margin: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              categories.length > i
                  ? GridButton(
                      title: categories[i].name,
                      cb: () {
                        print("Select ${categories[i].id}");
                      })
                  : GridButtonDisable(),
              categories.length > i + 1
                  ? GridButton(
                      title: categories[i + 1].name,
                      cb: () {
                        print("Select ${categories[i + 1].id}");
                      })
                  : GridButtonDisable(),
              // categories.length > i + 2
              //     ? GridButton(
              //         title: categories[i + 2].name,
              //         cb: () {
              //           print("Select ${categories[i + 2].id}");
              //         })
              //     : GridButtonDisable(),
            ],
          )));
    }
    return list;
  }
}
