import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/util/resource-util.dart';

class SellerStoreHeader extends StatelessWidget {
  final Company _company;

  const SellerStoreHeader(
    this._company, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is ProductListingSearchComplete) {
          return buildChild(context, state.result.total);
        }
        return buildChild(context, 0);
      },
    );
  }

  Widget buildChild(BuildContext context, int totalProducts) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Row(
          children: <Widget>[
            getSellerLogo(),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 30),
                      child: AutoSizeText(
                        _company.name,
                        minFontSize: 14,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10),
                      child: AutoSizeText(
                        totalProducts.toString() + " Products",
                        minFontSize: 12,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget getSellerLogo() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          ResourceUtil.fullPath(_company.image.imageUrl),
        ),
        radius: 25,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
