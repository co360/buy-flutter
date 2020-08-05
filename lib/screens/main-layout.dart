import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/navigation/bottom-navigation-bloc.dart';
import 'package:storeFlutter/blocs/shopping/sales-cart-bloc.dart';
import 'package:storeFlutter/components/navigator/custom-bottom-app-bar.dart';
import 'package:storeFlutter/util/app-theme.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> screens;

  MainLayout(this.screens);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBloc, int>(
        bloc: GetIt.I<BottomNavigationBloc>(),
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: this.screens,
          );
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedColor: AppTheme.colorPrimary,
        color: AppTheme.colorGray5,
//        onTabSelected: _selectedTab,
        items: [
          CustomBottomAppBarItem(
            iconData: FontAwesomeIcons.lightStore,
            text: FlutterI18n.translate(
                context, 'screen.bottomNavigation.market'),
          ),
          CustomBottomAppBarItem(
            iconData: FontAwesomeIcons.lightFileInvoiceDollar,
            text: FlutterI18n.translate(
                context, 'screen.bottomNavigation.orders'),
          ),
          CustomBottomAppBarItem(
            iconData: FontAwesomeIcons.lightShoppingCart,
            text:
                FlutterI18n.translate(context, 'screen.bottomNavigation.cart'),
            stacked: buildShoppingCartStacked(),
          ),
          CustomBottomAppBarItem(
            iconData: FontAwesomeIcons.lightUserCircle,
            text: FlutterI18n.translate(
                context, 'screen.bottomNavigation.account'),
          ),
        ],
      ),
    );
  }

  BlocBuilder<SalesCartBloc, SalesCartState> buildShoppingCartStacked() {
    return BlocBuilder<SalesCartBloc, SalesCartState>(
      bloc: GetIt.I<SalesCartBloc>(),
      builder: (context, state) {
        int total = GetIt.I<SalesCartBloc>().totalCart;

        if (total > 0) {
          return Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.colorOrange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6.0),
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
      },
    );
  }
}
