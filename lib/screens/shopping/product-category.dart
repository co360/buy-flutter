import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/shopping/category-lists.dart';
import 'package:storeFlutter/components/button/grid-button-left.dart';
import 'package:storeFlutter/components/button/grid-button-top.dart';

class ProductCategoryScreen extends StatefulWidget {
  @override
  _ProductCategoryScreenState createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  void initState() {
    // print("Initialize ForgotPassword Screen and State");
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // GetIt.I<ProductCategoryBloc>().add(InitProductCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("shopping.browse"),
      ),
      body: SafeArea(
        child: GestureDetector(
            onTap: () => {},
            behavior: HitTestBehavior.translucent,
            child: Row(children: <Widget>[
              Container(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: SingleChildScrollView(
                    child: Column(
                      children: _generateDynamicList(),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(int.parse("0xFFFFFFFF")),
                padding: const EdgeInsets.only(top: 20.0),
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        GridButtonTop(cb: () {
                          print("Select top button");
                        }),
                        CategoryLists()
                      ],
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }

  List<Widget> _generateDynamicList() {
    List<Widget> list = List();
    for (int i = 0; i < 100; i++) {
      if (i == 5)
        list.add(GridButtonLeft(
            title: "left true",
            isActive: true,
            cb: () {
              print("Select left button");
            }));
      else
        list.add(GridButtonLeft(
            title: "left false",
            isActive: false,
            cb: () {
              print("Select left button");
            }));
    }
    return list;
  }
}
