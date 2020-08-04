import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/models/shopping/order-rate-review.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/blocs/shopping/rating-bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductRating extends StatefulWidget {
  final Product product;

  ProductRating(this.product);

  @override
  _ProductRatingState createState() => _ProductRatingState();
}

class _ProductRatingState extends State<ProductRating> {
  @override
  Widget build(BuildContext context) {
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
        Text(
          FlutterI18n.translate(context, "shopping.productDetail.ratings"),
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
            child: ratingBody(context, ratings)),
        SizedBox(height: 15)
      ],
    ));
  }

  Widget ratingBody(BuildContext context, List<OrderRateReview> ratings) {
    double overallAvg = 0;
    double qualityAvg = 0;
    double deliveryAvg = 0;
    double serviceAvg = 0;
    double businessAvg = 0;

    if (ratings.length > 0) {
      for (var f in ratings) {
        overallAvg += f.averageRating;
        qualityAvg += f.productQuality;
        deliveryAvg += f.onTimeDelivery;
        serviceAvg += f.service;
        businessAvg += f.easeOfDoingBusiness;
      }

      overallAvg /= ratings.length;
      qualityAvg /= ratings.length;
      deliveryAvg /= ratings.length;
      serviceAvg /= ratings.length;
      businessAvg /= ratings.length;
    }

    return (Column(children: <Widget>[
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              overallAvg.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
            SizedBox(width: 10),
            Text(
              "/5",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colorGray5,
                  fontSize: 17),
            ),
          ]),
      Text(
        ratings.length.toString() +
            " " +
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.ratingsLabel"),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            color: AppTheme.colorGray6,
            fontSize: 14),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ratingIcon(overallAvg >= 0.5, overallAvg > 0, 30),
          ratingIcon(overallAvg >= 1.5, overallAvg > 1, 30),
          ratingIcon(overallAvg >= 2.5, overallAvg > 2, 30),
          ratingIcon(overallAvg >= 3.5, overallAvg > 3, 30),
          ratingIcon(overallAvg >= 4.5, overallAvg > 4, 30),
        ],
      ),
      SizedBox(height: 20),
      ratingsChild(
          FlutterI18n.translate(
              context, "shopping.productDetail.productQuality"),
          qualityAvg),
      SizedBox(height: 10),
      ratingsChild(
          FlutterI18n.translate(
              context, "shopping.productDetail.ontimeDelivery"),
          deliveryAvg),
      SizedBox(height: 10),
      ratingsChild(
          FlutterI18n.translate(context, "shopping.productDetail.service"),
          serviceAvg),
      SizedBox(height: 10),
      ratingsChild(
          FlutterI18n.translate(
              context, "shopping.productDetail.easeOfDoingBusiness"),
          businessAvg),
    ]));
  }

  Widget ratingsChild(String title, double avg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ),
        SizedBox(width: 10),
        ratingIcon(avg >= 0.5, avg > 0, 16),
        ratingIcon(avg >= 1.5, avg > 1, 16),
        ratingIcon(avg >= 2.5, avg > 2, 16),
        ratingIcon(avg >= 3.5, avg > 3, 16),
        ratingIcon(avg >= 4.5, avg > 4, 16),
        SizedBox(width: 5),
        Text(
          avg.toStringAsFixed(1),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
      ],
    );
  }

  Widget ratingIcon(bool primary, bool secondary, double size) {
    return FaDuotoneIcon(
      FontAwesomeIcons.duotoneStarHalf,
      primaryColor: primary ? AppTheme.colorYellow : AppTheme.colorGray2,
      secondaryColor: secondary ? AppTheme.colorYellow : AppTheme.colorGray2,
      size: size,
    );
  }
}
