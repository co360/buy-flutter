import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/blocs/account/city-bloc.dart';
import 'package:storeFlutter/components/list/search-list.dart';
import 'package:storeFlutter/util/enums-util.dart';

class CityList extends StatelessWidget {
  final String _state;

  CityList(this._state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CityBloc>(
      create: (context) => CityBloc()..add(GetCityListEvent(context, _state)),
      child: Builder(builder: (context) {
        return buildChild(context);
      }),
    );
  }

  Widget buildChild(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(builder: (context, state) {
      if (state is GetCityListSuccess) {
        return SearchList(
          placeholder: "Search city",
          initalValue: state.addresses,
          searchListType: enumSearchListType.CITY,
          extParam: _state,
        );
      }
      return SearchList(
        initalValue: [],
        searchListType: enumSearchListType.CITY,
        extParam: _state,
      );
    });
  }
}
