import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/navigation/bottom-navigation-bloc.dart';

class CustomBottomAppBarItem {
  CustomBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class CustomBottomAppBar extends StatelessWidget {
  final List<CustomBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final ValueChanged<int> onTabSelected;

  CustomBottomAppBar({
    this.items,
    this.height: 55.0,
    this.iconSize: 22.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, int>(
      bloc: GetIt.I<BottomNavigationBloc>(),
      builder: (context, state) {
        List<Widget> items = List.generate(
          this.items.length,
          (int index) {
            return _buildTabItem(
              item: this.items[index],
              index: index,
              selectedIndex: state,
              onPressed: (index) {
                GetIt.I<BottomNavigationBloc>().add(index);
              },
            );
          },
        );

        return BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items,
          ),
          color: backgroundColor,
        );
      },
    );
  }

  Widget _buildTabItem({
    CustomBottomAppBarItem item,
    int index,
    int selectedIndex,
    ValueChanged<int> onPressed,
  }) {
    Color color = selectedIndex == index ? this.selectedColor : this.color;
    return Expanded(
      child: SizedBox(
        height: this.height,
        child: GestureDetector(
          onTap: () => onPressed(index),
          behavior: HitTestBehavior.translucent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 3, bottom: 7),
                  child:
                      FaIcon(item.iconData, color: color, size: this.iconSize)),
              Text(
                item.text,
                style: TextStyle(color: color, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
