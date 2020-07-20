import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/shopping/search-bloc.dart';
import 'package:storeFlutter/components/shopping/custom-search-bar.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/screens/shopping/product-listing.dart';
import 'package:storeFlutter/services/product-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchGeneral extends StatefulWidget {
  @override
  _SearchGeneralState createState() => _SearchGeneralState();
}

class _SearchGeneralState extends State<SearchGeneral> {
  final SearchBarController<LabelValue> searchController =
      SearchBarController();
  final ProductService productService = GetIt.I<ProductService>();

  String searchedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          child: BlocProvider<SearchBloc>(
//            lazy: false,
            create: (context) => SearchBloc(),
            child: Builder(
              builder: (context) {
                return CustomSearchBar(
                  onSearch: (term) => search(context, term),
                  icon: null,
                  searchBarController: searchController,
                  minimumChars: 1,
                  emptyWidget: buildNotFound(),
                  placeHolder: buildPlaceHolder(),
                  loader: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.colorOrange),
                      strokeWidth: 3,
                    ),
                  ),
                  cancellationWidget: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      FlutterI18n.translate(context, "general.cancel"),
                      style: TextStyle(color: AppTheme.colorLink),
                    ),
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
                    return buildResult(labelValue, index, context);
                  },
                  onSubmitText: submitText,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNotFound() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        print("trigger bloc not found rebuild $state");
        if (state is SearchFinish) {
          return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    submitText(state.term);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    child: state.term == null
                        ? Text("")
                        : SubstringHighlight(
                            text: FlutterI18n.translate(
                                context, "shopping.searchWith",
                                translationParams: {"query": state.term}),
                            term: state.term,
                            textStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            textStyleHighlight: TextStyle(
                                fontSize: 14, color: AppTheme.colorLink),
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
        return Container();
      },
    );
  }

  Widget buildPlaceHolder() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text(
              FlutterI18n.translate(context, "shopping.searchProductSeller"),
              style: TextStyle(color: AppTheme.colorGray5),
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

  Widget buildResult(LabelValue labelValue, int index, BuildContext context) {
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
              submitText(labelValue.label);
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

  void submitText(String term) {
    Navigator.pushNamed(context, '/listing',
        arguments: ProductListingScreenParams(query: term));
  }

  Future<List<LabelValue>> search(BuildContext context, String search) async {
    BlocProvider.of<SearchBloc>(context).add(SearchWithTerm(search));
    return productService.keyWordByName(search);
  }
}
