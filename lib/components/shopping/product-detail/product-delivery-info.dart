import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/blocs/shopping/product-detail-bloc.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-response.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductDeliveryInfo extends StatelessWidget {
  final Location userAddress;
  final List<EasyParcelResponse> shipmentLists;

  ProductDeliveryInfo(
    this.userAddress,
    this.shipmentLists, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductDetailBloc productDetailBloc =
        BlocProvider.of<ProductDetailBloc>(context);
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      bloc: productDetailBloc,
      builder: (context, state) {
        if (state is ProductDetailSelectAddressComplete) {
          return buildChild(context, state.address, state.shipment);
        }
        return buildChild(context, userAddress, shipmentLists);
      },
    );
  }

  Widget buildChild(BuildContext context, Location address,
      List<EasyParcelResponse> shipments) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              alignment: Alignment.centerRight,
              child: FaIcon(
                FontAwesomeIcons.lightTruck,
                size: 16,
              ),
            ),
            SizedBox(width: 15),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                address == null
                    ? ""
                    : (address.city +
                        ", " +
                        address.state +
                        ", " +
                        address.postcode),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        courierDynamicList(context, shipments),
      ],
    );
  }

  Widget courierDynamicList(
      BuildContext context, List<EasyParcelResponse> shipments) {
    double minCost = 1000000;
    double maxCost = 0;
    DateTime minDate = new DateTime(2080, 1, 1, 0, 0);
    DateTime maxDate = new DateTime(2000, 1, 1, 0, 0);
    if (shipments != null && shipments.length > 0) {
      for (var f in shipments) {
        if (f.price < minCost) minCost = f.price;
        if (f.price > maxCost) maxCost = f.price;
        DateTime dateFrom = new DateTime(f.delivery_dates.from.year,
            f.delivery_dates.from.month, f.delivery_dates.from.day, 0, 0);
        DateTime dateTo = new DateTime(f.delivery_dates.to.year,
            f.delivery_dates.to.month, f.delivery_dates.to.day, 0, 0);
        if (dateFrom.isBefore(minDate)) minDate = dateFrom;
        if (dateTo.isAfter(maxDate)) maxDate = dateTo;
      }
    } else {
      minCost = 0;
      minDate = new DateTime(2000, 1, 1, 0, 0);
    }
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              FlutterI18n.translate(context, "shopping.productDetail.cost"),
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              shipments == null || shipments.length == 0
                  ? " - "
                  : (shipments.length > 1
                      ? "RM " +
                          minCost.toStringAsFixed(2) +
                          " - RM " +
                          maxCost.toStringAsFixed(2)
                      : "RM " + minCost.toStringAsFixed(2)),
              textAlign: TextAlign.left,
              style: TextStyle(color: AppTheme.colorOrange, fontSize: 14),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              FlutterI18n.translate(
                  context, "shopping.productDetail.receivedBy"),
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              shipments == null || shipments.length == 0
                  ? " - "
                  : (minDate.day.toString() +
                      " " +
                      reformatMonth(minDate.month) +
                      " - " +
                      maxDate.day.toString() +
                      " " +
                      reformatMonth(maxDate.month)),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    ]);
  }

  String reformatMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}
