import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/constants/app_const.dart';
import 'package:simplerecharge/utils/url_launcher.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';

class AppUpdatePage extends StatefulWidget {
  @override
  _AppUpdatePageState createState() => _AppUpdatePageState();
}

class _AppUpdatePageState extends State<AppUpdatePage> {
  final appState = getIt.get<AppState>();

  @override
  void initState() {
    super.initState();
  }

  void onUpdate(BuildContext context) {
    if (Platform.isAndroid == true) {
      launchURL(context, PLAYSTORE_PATH);
    } else {
      launchURL(context, APPSTORE_PATH);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: [
              SizedBox(height: 75.0),
              Container(
                alignment: Alignment.center,
                child: Text(appState.getTranslation("Version_Update"),
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 25.0),
              CustomImage(
                  height: 70.0,
                  width: 70.0,
                  imgPath: "assets/images/app_logo.png"),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Simple Recharge",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: AppColors.primary,
                          fontFamily: 'Sansation',
                          fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: 25.0),
              Container(
                padding: EdgeInsets.only(left: 18.0, right: 18.0),
                alignment: Alignment.center,
                child: Text(appState.getTranslation("We_are_better_than_ever"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15.0),
              Container(
                  padding: EdgeInsets.only(left: 18.0, right: 18.0),
                  alignment: Alignment.center,
                  child: Text(
                    appState.getTranslation("We_have_added_new_features"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )),
              SizedBox(height: 35.0),
            ]),
            Container(
              padding: EdgeInsets.only(bottom: 80.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
                child: Text(appState.getTranslation("Update"),
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  onUpdate(context);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
