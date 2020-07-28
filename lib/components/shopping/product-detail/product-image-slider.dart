import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/util/resource-util.dart';

class ProductImageSlider extends StatefulWidget {
  final Product product;

  ProductImageSlider(this.product);

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _current = 0;

  List<Widget> imageSliders(BuildContext context) {
    return widget.product.images
        .map(
          (img) => Container(
            child: Image.network(
              ResourceUtil.fullPath(img.imageUrl),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1,
            autoPlay: false,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: imageSliders(context),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(30)),
//              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              "${_current + 1}/${widget.product.images.length}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
