import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/resource-util.dart';

class ProductListingGridItem extends StatelessWidget {
  final Product product;

  ProductListingGridItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.colorGray4, width: 0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5),
              ),
              child: Image.network(
                ResourceUtil.fullPath(product.images[0].imageUrl),
                fit: BoxFit.cover,
                height: 180,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "RM 22.00",
                    style: TextStyle(
                        color: AppTheme.colorOrange,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Divider(
              color: AppTheme.colorGray4,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      getSellerLogo(),
                      Expanded(
                        child: Text(
                          product.sellerCompany.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    getLocationInfo(),
                    style: TextStyle(
                      color: AppTheme.colorPrimary,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSellerLogo() {
    if (product.sellerCompany != null && product.sellerCompany.image != null) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 20,
          child: Container(
            child: Image.network(
              ResourceUtil.fullPath(product.sellerCompany.image.imageUrl),
              fit: BoxFit.cover,
//          width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  String getLocationInfo() {
    String locationInfo;

    if (product.sellerCompanyProfile != null) {
      Location location = product.sellerCompanyProfile.locations
          .firstWhere((element) => element.supplyLocation);

      if (location != null) {
        if (isBlank(locationInfo))
          locationInfo = location.city +
              (isBlank(location.state) ? '' : ', ' + location.state);
        if (isBlank(locationInfo)) locationInfo = location.countryName;
      }
    }

    if (isBlank(locationInfo)) {
      if (product.sellerCompany != null) {
        if (isBlank(locationInfo)) locationInfo = product.sellerCompany.city;
        if (isBlank(locationInfo))
          locationInfo = product.sellerCompany.countryName;
      }
    }

    return locationInfo;
  }
}
