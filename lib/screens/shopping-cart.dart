import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/navigation/bottom-navigation-bloc.dart';
import 'package:storeFlutter/blocs/shopping/sales-cart-bloc.dart';
import 'package:storeFlutter/components/account/check-session.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-general-error-info.dart';
import 'package:storeFlutter/components/app-loading.dart';
import 'package:storeFlutter/models/shopping/sales-cart.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    StorageService storageService = GetIt.I<StorageService>();
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, "screen.bottomNavigation.cart"),
          style: TextStyle(color: Colors.white),
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
      body: CheckSession(
        child: ShoppingCartBody(),
      ),
    );
  }
}

class ShoppingCartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCartBloc, SalesCartState>(
      bloc: GetIt.I<SalesCartBloc>(),
      builder: (context, state) {
        if (state is SalesCartRefreshFailed) {
          return AppGeneralErrorInfo(state.error);
        } else if (state is SalesCartRefreshInProgress) {
          return AppLoading();
        } else if (state is SalesCartRefreshComplete) {
//          return ShoppingCartBodyWithConten(state.cart);

//          return buildEmptyShoppingCart(context);
          return state.cart.cartDocs != null && state.cart.cartDocs.length > 0
              ? ShoppingCartBodyWithContent(state.cart)
              : buildEmptyShoppingCart(context);
        }
        return Container();
      },
    );
  }

  Widget buildEmptyShoppingCart(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingStandard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            FlutterI18n.translate(context, "cart.shoppingCartEmpty"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              FlutterI18n.translate(context, "cart.shoppingCartEmptyMsg"),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: AppButton(
              FlutterI18n.translate(context, "cart.goShoppingNow"),
              () => GetIt.I<BottomNavigationBloc>().add(0),
              size: AppButtonSize.small,
            ),
          )
        ],
      ),
    );
  }
}

class ShoppingCartBodyWithContent extends StatelessWidget {
  final SalesCart salesCart;

  ShoppingCartBodyWithContent(this.salesCart);

  @override
  Widget build(BuildContext context) {
    return Text("not empty really");
  }
}
