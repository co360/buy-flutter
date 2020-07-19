import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppLoadingDialog {
  String text;
  final BuildContext context;

  BuildContext builderContext;

  AppLoadingDialog(this.context, {this.text}) {
    if (this.text == null) {
      this.text = FlutterI18n.translate(context, "general.pleaseWait");
    }
    _showDialog();
  }

  _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        builderContext = context;
        return WillPopScope(
          onWillPop: () {},
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            content: Row(
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.colorOrange),
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 3,
                  ),
                )
              ],
            ),
//            actions: <Widget>[
//              new FlatButton(
//                onPressed: () {
//                  //Function called
//                },
//                child: new Text('Ok Done!'),
//              ),
//              new FlatButton(
//                onPressed: () {
////                  Navigator.pop(context);
//                  pop();
//                },
//                child: new Text('Go Back'),
//              ),
//            ],
          ),
        );
      },
    );
  }

//  pop() {
//    print('calling pop in side app-loading-dialog');
////    Navigator.pop(builderContext);
////    Navigator.of(context, rootNavigator: true).pop('dialog');
//
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      Navigator.pop(context);
//    });
//  }
}
