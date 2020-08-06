import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/blocs/account/country-bloc.dart';
import 'package:storeFlutter/components/list/search-list.dart';
import 'package:storeFlutter/util/enums-util.dart';

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryBloc>(
      create: (context) => CountryBloc()..add(GetCountryListEvent(context)),
      child: Builder(builder: (context) {
        return buildChild(context);
      }),
    );
  }

  Widget buildChild(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
      return SearchList(
        placeholder: "Select country",
        searchListType: enumSearchListType.COUNTRY,
      );
    });
  }
}
