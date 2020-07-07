import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/components/navigator/bottom_app_bar.dart';
import 'package:storeFlutter/util/app-theme.dart';

class MainLayout extends StatefulWidget {
  final List<Widget> screens;

  MainLayout(this.screens);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print('<<< this should be rebuild only when change language');
    // have to move into here so all of the screen is rebuilt when change language
//    List<Widget> allDestinations = <Widget>[
//      HomeScreen(),
//      OrdersScreen(),
//      ShoppingCartScreen(),
//      AccountScreen()
//    ];

    return Scaffold(
//      body: allDestinations.elementAt(_selectedIndex),
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedColor: AppTheme.colorPrimary,
        color: AppTheme.colorGray5,
        onTabSelected: _selectedTab,
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
}
