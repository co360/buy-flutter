import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app-list-tile.dart';
import 'package:storeFlutter/components/shopping/custom-search-bar.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/product-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchGeneral extends StatefulWidget {
  @override
  _SearchGeneralState createState() => _SearchGeneralState();
}

class _SearchGeneralState extends State<SearchGeneral> {
//  final SearchBarController<Post> searchController = SearchBarController();
  final SearchBarController<LabelValue> searchController =
      SearchBarController();
  final ProductService productService = ProductService.getInstance();

  String searchedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          child: CustomSearchBar(
            onSearch: search2,
            icon: null,
            searchBarController: searchController,
            emptyWidget: Text("Not found"),
            placeHolder: Text("Please key in something to search"),
            loader: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.colorOrange),
                strokeWidth: 3,
              ),
            ),
            cancellationWidget: Text(
              FlutterI18n.translate(context, "general.cancel"),
              style: TextStyle(color: AppTheme.colorLink),
            ),
            searchBarPadding:
                EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            searchBarStyle: SearchBarStyle(
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: AppTheme.colorGray2,
                borderRadius: BorderRadius.circular(5)),
            listPadding: EdgeInsets.only(top: 0),
            onCancelled: () {
              Navigator.pop(context);
            },
            onItemFound: (LabelValue labelValue, int index) {
              return buildResult2(labelValue, index, context);
            },
//            onItemFound: (Post post, int index) {
//              return buildResult(post, index, context);
//            },
          ),
        ),
      ),
    );
  }

  Widget buildResult(Post post, int index, BuildContext context) {
    print('last search ${searchController.lastSearchedText}');
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('click result');
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SubstringHighlight(
                text: post.title,
                term: searchController.lastSearchedText,
//                term: 'fdsa',
                textStyle: TextStyle(fontSize: 14, color: Colors.black),
                textStyleHighlight:
                    TextStyle(fontSize: 14, color: AppTheme.colorLink),
              ),
//              child: Text(
//                post.title,
//                style: TextStyle(fontSize: 16),
//              ),
            ),
          ),
//          ListTile(
//            onTap: () {},
//            title: Text(post.title),
////            dense: true,
////            contentPadding: EdgeInsets.zero,
//          ),
          Divider(
            color: AppTheme.colorGray3,
            height: 1,
          )
        ],
      ),
    );

    return AppListTile(
      post.title,
      topDivider: index == 0 ? false : false,
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
    );
  }

  Widget buildResult2(LabelValue labelValue, int index, BuildContext context) {
    print('last search ${searchController.lastSearchedText}');
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('click result');
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SubstringHighlight(
                text: labelValue.label,
                term: searchController.lastSearchedText,
                textStyle: TextStyle(fontSize: 14, color: Colors.black),
                textStyleHighlight:
                    TextStyle(fontSize: 14, color: AppTheme.colorLink),
              ),
            ),
          ),
          Divider(
            color: AppTheme.colorGray3,
            height: 1,
          )
        ],
      ),
    );
  }

  Future<List<Post>> search(String search) async {
    productService.keyWordByName(search);

    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  Future<List<LabelValue>> search2(String search) async {
    return productService.keyWordByName(search);
  }
}

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}
