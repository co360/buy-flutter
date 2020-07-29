import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/screens/account/manage-address.dart';

class AddressEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 40.0),
              child: Text(
                FlutterI18n.translate(context, "account.noAddress"),
                textAlign: TextAlign.center,
              )),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: 264,
              child: AppButton(
                FlutterI18n.translate(context, "account.addAddressNow"),
                () => {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ManageAddressScreen(0),
                    ),
                  )
                },
                size: AppButtonSize.small,
                noPadding: true,
              ),
            ),
          ),
        ]);
  }
}
