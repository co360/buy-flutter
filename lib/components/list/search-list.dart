import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/shopping/search-bloc.dart';
import 'package:storeFlutter/components/shopping/custom-search-bar.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/city-service.dart';
import 'package:storeFlutter/services/country-service.dart';
import 'package:storeFlutter/services/state-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/enums-util.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchList extends StatefulWidget {
  final String query;
  final String placeholder;
  final enumSearchListType searchListType;
  final String extParam;
  final List<LabelValue> initalValue;

  SearchList(
      {this.query,
      this.placeholder,
      this.initalValue,
      this.searchListType,
      this.extParam});

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final SearchBarController<LabelValue> searchController =
      SearchBarController();
  final CountryService _countryService = GetIt.I<CountryService>();
  final StateService _stateService = GetIt.I<StateService>();
  final CityService _cityService = GetIt.I<CityService>();

  String searchedText;
  FocusNode searchFN = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          child: BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(),
            child: Builder(
              builder: (context) {
                return CustomSearchBar(
                  onSearch: (term) => search(context, term),
                  icon: null,
                  searchQueryController:
                      TextEditingController(text: widget.query),
                  hintText: widget.placeholder,
                  searchBarController: searchController,
                  searchFocusNode: searchFN,
                  minimumChars: 1,
                  emptyWidget: buildNotFound(),
                  placeHolder: buildPlaceHolder(context),
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
                    submitText("None:None");
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

  Widget buildPlaceHolder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 1,
          itemCount: widget.initalValue.length,
          shrinkWrap: false,
          staggeredTileBuilder: (int index) => ScaledTile.fit(1),
          scrollDirection: Axis.vertical,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          addAutomaticKeepAlives: true,
          itemBuilder: (BuildContext context, int index) {
            return buildResult(widget.initalValue[index], index, context);
          },
        ),
      ),
    );
  }

  Widget buildPlaceHolderBackup() {
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
    print(
        'last search ${searchController.lastSearchedText} ${labelValue.label}');
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('click result');
              submitText((labelValue.code == null
                      ? labelValue.label
                      : labelValue.code) +
                  ":" +
                  labelValue.label);
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SubstringHighlight(
                text: labelValue.label,
                term: searchController.lastSearchedText == null
                    ? ""
                    : searchController.lastSearchedText,
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

  void submitText(String term) async {
    LabelValue temp =
        new LabelValue(code: term.split(":")[0], label: term.split(":")[1]);
    Navigator.pop(context, temp);
  }

  Future<List<LabelValue>> search(BuildContext context, String search) async {
    switch (widget.searchListType) {
      case enumSearchListType.STATE:
        BlocProvider.of<SearchBloc>(context).add(SearchWithTerm(search));
        return _stateService.filterStateByName(
            context, search, widget.extParam);
        break;
      case enumSearchListType.CITY:
        BlocProvider.of<SearchBloc>(context).add(SearchWithTerm(search));
        return _cityService.filterCityByName(context, search, widget.extParam);
        break;
      default:
        BlocProvider.of<SearchBloc>(context).add(SearchWithTerm(search));
        return _countryService.filterCountryByName(context, search);
        break;
    }
  }
}
