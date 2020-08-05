import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/account/address-view.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/screens/account/manage-address.dart';
import 'package:storeFlutter/util/enums-util.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.myAddresses"),
        actions: <Widget>[
          FlatButton(
            textColor: AppTheme.colorLink,
            onPressed: () => {
              Navigator.pushReplacement(
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
              return AddressView(enumAddressViewType.EDIT, 0, editAddressEvt);
            },
          ),
        ),
      ),
    );
  }

  void editAddressEvt(BuildContext context, int id) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => ManageAddressScreen(id),
      ),
    );
  }
}
