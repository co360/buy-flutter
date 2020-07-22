import 'package:flutter/material.dart';
import 'package:storeFlutter/components/shopping/category-grid-list.dart';

class CategoryLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _generateDynamicList(),
    );
  }

  List<Widget> _generateDynamicList() {
    List<Widget> list = List();
    for (int i = 0; i < 5; i++) {
      list.add(CategoryGridList());
    }
    return list;
  }
}
