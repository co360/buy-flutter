import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/blocs/shopping/product-detail-bloc.dart';
import 'package:storeFlutter/components/account/address-view.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/screens/account/manage-address.dart';
import 'package:storeFlutter/util/enums-util.dart';

class ProductSelectAddress extends StatelessWidget {
  final ProductDetailBloc productDetailBloc;
  final int selectId;

  ProductSelectAddress(this.productDetailBloc, this.selectId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("shopping.productDetail.selectAddress"),
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
              return AddressView(
                  enumAddressViewType.SELECT, selectId, selectAddressEvt);
            },
          ),
        ),
      ),
    );
  }

  void selectAddressEvt(BuildContext context, int id) {
    print("[selectAddress] $id");
    productDetailBloc.add(ProductDetailSelectAddress(id));
    Navigator.pop(context);
  }
}
