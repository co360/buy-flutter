import 'package:flutter/material.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';

class SellerStore extends StatelessWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  SellerStore(this.sellerCompany, this.sellerCompanyProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Company"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[Text(sellerCompany.name)],
        ),
      ),
    );
  }
}
