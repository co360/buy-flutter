import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/models/shopping/order-rate-review.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/blocs/shopping/rating-bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductReview extends StatefulWidget {
  final Product product;

  ProductReview(this.product);

  @override
  _ProductReviewState createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  bool seeAllFlag = false;

  @override
  Widget build(BuildContext context) {
    print("[ProductReview] Rebuild $seeAllFlag");
    return BlocProvider<RatingBloc>(
        create: (context) =>
            RatingBloc()..add(LoadRatingByProductIdEvent(widget.product.id)),
        child: BlocBuilder<RatingBloc, RatingState>(builder: (context, state) {
          if (state is LoadRatingSuccess) {
            return buildChild(context, state.ratings);
          }
          return buildChild(context, []);
        }));
  }

  Widget buildChild(BuildContext context, List<OrderRateReview> ratings) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "shopping.productDetail.reviews"),
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ratings.length > 0
                ? FlatButton(
                    textColor: AppTheme.colorLink,
                    onPressed: () {
                      setState(() {
                        seeAllFlag = !seeAllFlag;
                      });
                    },
                    child: Text(FlutterI18n.translate(
                        context,
                        seeAllFlag
                            ? "shopping.productDetail.seeLess"
                            : "shopping.productDetail.seeAll")),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent)),
                  )
                : Container(),
          ],
        ),
        SizedBox(height: 10),
        Container(
          color: Colors.white,
          // padding: EdgeInsets.only(right: 10, left: 10),
          child: ratings.length == 0
              ? noReviewBody(context)
              : Column(children: dynamicReviewBody(context, ratings)),
        ),
      ],
    ));
  }

  Widget noReviewBody(BuildContext context) {
    return (Column(children: <Widget>[
      SizedBox(height: 15),
      Text(FlutterI18n.translate(
          context, "shopping.productDetail.noReviewsYet")),
      SizedBox(height: 15),
    ]));
  }

  Widget ratingIcon(bool primary, bool secondary, double size) {
    return FaDuotoneIcon(
      FontAwesomeIcons.duotoneStarHalf,
      primaryColor: primary ? AppTheme.colorYellow : AppTheme.colorGray2,
      secondaryColor: secondary ? AppTheme.colorYellow : AppTheme.colorGray2,
      size: size,
    );
  }

  List<Widget> dynamicReviewBody(
      BuildContext context, List<OrderRateReview> ratings) {
    List<Widget> lists = List();
    for (var f in ratings) {
      lists.add(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(f.title == null ? "Anonymous" : f.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ratingIcon(f.averageRating.toDouble() >= 0.5,
                            f.averageRating.toDouble() > 0, 16),
                        ratingIcon(f.averageRating.toDouble() >= 1.5,
                            f.averageRating.toDouble() > 1, 16),
                        ratingIcon(f.averageRating.toDouble() >= 2.5,
                            f.averageRating.toDouble() > 2, 16),
                        ratingIcon(f.averageRating.toDouble() >= 3.5,
                            f.averageRating.toDouble() > 3, 16),
                        ratingIcon(f.averageRating.toDouble() >= 4.5,
                            f.averageRating.toDouble() > 4, 16),
                      ],
                    ),
                  )
                ]),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Text(f.review == null ? "" : f.review),
          ),
          SizedBox(height: f.review == null ? 0 : 15),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(children: <Widget>[
              Text(
                  f.dateCreated.day < 10
                      ? "0" + f.dateCreated.day.toString()
                      : f.dateCreated.day.toString() +
                          "/" +
                          (f.dateCreated.month < 10
                              ? "0" + f.dateCreated.month.toString()
                              : f.dateCreated.month.toString()) +
                          "/" +
                          f.dateCreated.year.toString(),
                  style: TextStyle(
                      color: AppTheme.colorLink,
                      fontWeight: FontWeight.normal,
                      fontSize: 14)),
              Text(
                  " | " +
                      (f.salesOrder.orderItems != null &&
                              f.salesOrder.orderItems.length > 0 &&
                              f.salesOrder.orderItems[0].product != null &&
                              f.salesOrder.orderItems[0].product.name != null
                          ? f.salesOrder.orderItems[0].product.name
                          : "-"),
                  style: TextStyle(
                      color: AppTheme.colorGray6,
                      fontWeight: FontWeight.normal,
                      fontSize: 14)),
            ]),
          ),
          SizedBox(height: 15),
          Divider(
            color: AppTheme.colorGray3,
            height: 1,
            thickness: 1,
          ),
        ]),
      );
      if (!seeAllFlag) break;
    }

    // lists.insert(
    //   0,
    //   Divider(
    //     color: AppTheme.colorGray3,
    //     height: 1,
    //     thickness: 1,
    //   ),
    // );
    return lists;
  }
}
