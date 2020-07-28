import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/account/address-empty.dart';
import 'package:storeFlutter/components/account/address-view.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/screens/account/manage-address.dart';
import 'package:storeFlutter/models/identity/location.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();
  List<Location> lists = [];

  @override
  void initState() {
    print("Initialize Address Screen and State");
    GetIt.I<AddressBloc>()
        .add(GetAddressEvent(storageService.loginUser.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.myAddresses"),
        actions: <Widget>[
          FlatButton(
            textColor: AppTheme.colorLink,
            onPressed: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ManageAddressScreen(0),
                ),
              )
            },
            child: Text(FlutterI18n.translate(context, "account.add")),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          behavior: HitTestBehavior.translucent,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: BlocBuilder<AddressBloc, AddressState>(
                    bloc: GetIt.I<AddressBloc>(),
                    builder: (context, state) {
                      print("current state $state");

                      if (state is GetAddressSuccess) {
                        print(state.addresses);
                        if (state.addresses.length > 0) {
                          lists = state.addresses;
                          GetIt.I<AddressBloc>().add(InitAddressEvent());
                        }
                      }

                      if (lists.length > 0) {
                        return AddressView(lists);
                      } else {
                        return AddressEmpty();
                      }
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
