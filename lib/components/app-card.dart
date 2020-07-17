import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Widget footer;
  final EdgeInsets padding;

  const AppCard(this.child,
      {this.footer, this.padding = const EdgeInsets.all(20)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.paddingStandard),
      child: Card(
        shadowColor: Color(0xFF2E95C6).withOpacity(0.3),
        elevation: 3,
//        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: this.footer == null
            ? Padding(
                padding: padding,
                child: this.child,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: padding,
                    child: this.child,
                  ),
                  Divider(
                    color: AppTheme.colorGray4,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: this.footer,
                  )
                ],
              ),
      ),
    );
  }
}
