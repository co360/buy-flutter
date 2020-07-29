import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/shopping/sales-cart-bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ShoppingCartIcon extends StatelessWidget {
  final bool dark;

  ShoppingCartIcon({this.dark = false});

  final double iconPaddingHeight = 5;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _tap(context),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: iconPaddingHeight,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: FaIcon(
                  FontAwesomeIcons.lightShoppingCart,
                  color: dark ? Colors.black : Colors.white,
                  size: 25,
                ),
              ),
              SizedBox(
                height: iconPaddingHeight,
              ),
            ],
          ),
          BlocBuilder<SalesCartBloc, SalesCartState>(
              bloc: GetIt.I<SalesCartBloc>(),
              builder: (context, state) {
                int total = 0;
                if (state is SalesCartRefreshComplete) {
                  total = state.cart.cartDocs.length;
                }

                if (total > 0) {
                  return Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.colorOrange,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 6.0),
                        child: Text(
                          total.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              })
        ],
      ),
    );
  }

  void _tap(BuildContext context) {
    Navigator.of(context).pushNamed("/cart");
  }
}
