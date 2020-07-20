import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/screens/shopping/product-listing.dart';
import 'package:storeFlutter/util/app-theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: StaticSearchBar(FlutterI18n.translate(
                  context, "shopping.searchProductSeller")),
            ),
            SizedBox(width: 10),
            BrowseButton()
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        HomePageSlider(),
        PromoWidget(),
        Text("product category suggestion...")
      ],
    );
  }

  Widget buildTest(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          AppButton(
            "Push Page Route",
            () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductListingScreen()))
            },
          ),
          AppButton(
            "Push Named Route",
            () => {
              Navigator.pushNamed(context, '/listing'),
            },
          )
        ],
      ),
    );
  }
}

class PromoWidget extends StatelessWidget {
  const PromoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildPromoItem('Penghantaran Percuma', 'free-delivery.png'),
          buildPromoItem('Penjual Tulen', 'best-seller.png'),
          buildPromoItem('Pasar Tani', 'farmer.png'),
          buildPromoItem('Harga Terendah', 'lowest-price.png'),
          buildPromoItem('Makanan & Minuman', 'foods.png'),
        ],
      ),
    );
  }

  Widget buildPromoItem(String title, String imagePath) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image(
                height: 35,
                image: AssetImage('assets/images/promo/$imagePath'),
              ),
            ),
            SizedBox(height: 5),
            AutoSizeText(
              title,
              wrapWords: false,
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 10,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageSlider extends StatefulWidget {
  const HomePageSlider({
    Key key,
  }) : super(key: key);

  @override
  _HomePageSliderState createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  final List<String> imgList = [
    'https://previews.123rf.com/images/varijanta/varijanta1601/varijanta160100046/51310252-thin-line-flat-design-banner-of-online-shopping-e-commerce-m-commerce-modern-vector-illustration-con.jpg',
    'https://www.lamartpots.eu/getattachment/1714f9cc-ed16-4aa3-9311-3072576ca49c/b5c58524-1b8f-48af-9aab-824f6780a098.aspx',
    'https://image.freepik.com/free-vector/hello-summer-tropic-fruits-banner_1268-11173.jpg',
    'https://media2.motherhood.com.my/modules/homeslider/images/3a27521c69ac62503474ba5958b1e8e1d6396a93_hero-banner.png',
  ];

  int _current = 0;

  List<Widget> imageSliders(BuildContext context) {
    return imgList
        .map((item) => Container(
              child: Image.network(
                item,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 21 / 9,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 8),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: imageSliders(context),
        ),
        Positioned(
          bottom: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: Row(
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class BrowseButton extends StatelessWidget {
  const BrowseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FaIcon(
          FontAwesomeIcons.lightBoxFull,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          FlutterI18n.translate(context, "shopping.browse"),
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
