import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/blocs/shopping/rating-bloc.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/shopping/order-rate-review.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/util/app-theme.dart';

class SellerStoreReview extends StatefulWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  SellerStoreReview(this.sellerCompany, this.sellerCompanyProfile);
  @override
  _SellerStoreReviewState createState() => _SellerStoreReviewState();
}

class _SellerStoreReviewState extends State<SellerStoreReview> {
  @override
  void initState() {
    print("Initialize SellerStoreReview and State");
    GetIt.I<RatingBloc>()
        .add(LoadRatingByCompanyIdEvent(widget.sellerCompany.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(
      bloc: GetIt.I<RatingBloc>(),
      builder: (context, state) {
        if (state is LoadRatingSuccess) {
          return buildChild(context, state.ratings);
        }
        return buildChild(context, []);
      },
    );
  }

  Widget buildChild(BuildContext context, List<OrderRateReview> ratings) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.sellerStorePage.overallRatings")),
        ),
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20, bottom: 20, right: 5, left: 5),
            child: ratingBody(context, ratings)),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.sellerStorePage.reviewsLabel")),
        ),
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

  Widget ratingBody(BuildContext context, List<OrderRateReview> ratings) {
    double avg = 0;
    if (ratings.length > 0) {
      for (var f in ratings) {
        avg = avg + f.averageRating;
      }

      avg = avg / ratings.length;
    }

    return (Column(children: <Widget>[
      Text(
        avg.toStringAsFixed(2),
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStarHalf,
            primaryColor:
                avg >= 0.5 ? AppTheme.colorYellow : AppTheme.colorGray2,
            secondaryColor:
                avg > 0 ? AppTheme.colorYellow : AppTheme.colorGray2,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStarHalf,
            primaryColor:
                avg >= 1.5 ? AppTheme.colorYellow : AppTheme.colorGray2,
            secondaryColor:
                avg > 1 ? AppTheme.colorYellow : AppTheme.colorGray2,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStarHalf,
            primaryColor:
                avg >= 2.5 ? AppTheme.colorYellow : AppTheme.colorGray2,
            secondaryColor:
                avg > 2 ? AppTheme.colorYellow : AppTheme.colorGray2,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStarHalf,
            primaryColor:
                avg >= 3.5 ? AppTheme.colorYellow : AppTheme.colorGray2,
            secondaryColor:
                avg > 3 ? AppTheme.colorYellow : AppTheme.colorGray2,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStarHalf,
            primaryColor:
                avg >= 4.5 ? AppTheme.colorYellow : AppTheme.colorGray2,
            secondaryColor:
                avg > 4 ? AppTheme.colorYellow : AppTheme.colorGray2,
            size: 30,
          ),
        ],
      ),
      SizedBox(height: 15),
      Text(
        ratings.length.toString() +
            " " +
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.ratingsLabel"),
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      ),
    ]));
  }

  Widget noReviewBody(BuildContext context) {
    return (Column(children: <Widget>[
      SizedBox(height: 15),
      Text(FlutterI18n.translate(
          context, "shopping.sellerStorePage.noReviewsYet")),
      SizedBox(height: 15),
    ]));
  }

  List<Widget> dynamicReviewBody(
      BuildContext context, List<OrderRateReview> ratings) {
    List<Widget> lists = List();
    for (var f in ratings) {
      lists.add(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                        FaDuotoneIcon(
                          FontAwesomeIcons.duotoneStarHalf,
                          primaryColor: f.averageRating.toDouble() >= 0.5
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          secondaryColor: f.averageRating.toDouble() > 0
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          size: 16,
                        ),
                        FaDuotoneIcon(
                          FontAwesomeIcons.duotoneStarHalf,
                          primaryColor: f.averageRating.toDouble() >= 1.5
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          secondaryColor: f.averageRating.toDouble() > 1
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          size: 16,
                        ),
                        FaDuotoneIcon(
                          FontAwesomeIcons.duotoneStarHalf,
                          primaryColor: f.averageRating.toDouble() >= 2.5
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          secondaryColor: f.averageRating.toDouble() > 2
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          size: 16,
                        ),
                        FaDuotoneIcon(
                          FontAwesomeIcons.duotoneStarHalf,
                          primaryColor: f.averageRating.toDouble() >= 3.5
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          secondaryColor: f.averageRating.toDouble() > 3
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          size: 16,
                        ),
                        FaDuotoneIcon(
                          FontAwesomeIcons.duotoneStarHalf,
                          primaryColor: f.averageRating.toDouble() >= 4.5
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          secondaryColor: f.averageRating.toDouble() > 4
                              ? AppTheme.colorYellow
                              : AppTheme.colorGray2,
                          size: 16,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(f.review == null ? "" : f.review),
          ),
          SizedBox(height: f.review == null ? 0 : 15),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
    }

    lists.insert(
      0,
      Divider(
        color: AppTheme.colorGray3,
        height: 1,
        thickness: 1,
      ),
    );
    return lists;
  }
}
