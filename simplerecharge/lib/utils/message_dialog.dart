import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';

final appState = getIt.get<AppState>();

Future<void> showMessageDialog(
    BuildContext context, String title, String msg) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        content: Text(msg, style: TextStyle(fontSize: 16.0)),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(appState.getTranslation("Ok"),
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
