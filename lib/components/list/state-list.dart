import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/blocs/account/state-bloc.dart';
import 'package:storeFlutter/components/list/search-list.dart';
import 'package:storeFlutter/util/enums-util.dart';

class StateList extends StatelessWidget {
  final String _country;

  StateList(this._country);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StateBloc>(
      create: (context) =>
          StateBloc()..add(GetStateListEvent(context, _country)),
      child: Builder(builder: (context) {
        return buildChild(context);
      }),
    );
  }

  Widget buildChild(BuildContext context) {
    return BlocBuilder<StateBloc, StateState>(builder: (context, state) {
      if (state is GetStateListSuccess) {
        return SearchList(
          placeholder: "Search state",
          initalValue: state.addresses,
          searchListType: enumSearchListType.STATE,
          extParam: _country,
        );
      }
      return SearchList(
        initalValue: [],
        searchListType: enumSearchListType.STATE,
        extParam: _country,
      );
    });
  }
}
