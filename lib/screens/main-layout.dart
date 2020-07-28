import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/navigation/bottom-navigation-bloc.dart';
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
