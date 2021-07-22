import 'dart:async';
import 'package:simplerecharge/constants/app_const.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final appState = getIt.get<AppState>();
  late StreamSubscription appStateSub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    appStateSub.cancel();
    super.dispose();
  }

  Future<void> getAppConfig() async {
    try {
      await appState.getSimInfo();
      String remoteConfigVersion = await setupRemoteConfig();
      print("remoteConfigVersion=" +
          remoteConfigVersion +
          " ANDROID_VERSION=" +
          ANDROID_VERSION);
      if (remoteConfigVersion == ANDROID_VERSION) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/appUpdate');
      }
    } catch (err) {
      print("APP_CONFIG_CHECK_ERR");
    }
  }

  Future<String> setupRemoteConfig() async {
    await Firebase.initializeApp();
    final RemoteConfig remoteConfig = RemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await remoteConfig.setDefaults(<String, dynamic>{
      'app_version_param': ANDROID_VERSION,
    });
    await remoteConfig.fetchAndActivate();

    return remoteConfig.getString('app_version_param');
  }

  @override
  Widget build(BuildContext context) {
    appStateSub = appState.cStateAppState.cubeStream$
        .distinct((v1, v2) {
          return v1 == v2;
        })
        .debounceTime(Duration(milliseconds: 400))
        .listen((onData) {
          if (onData == 1) {
            getAppConfig();
          } else if (onData == -1) {
            print("APP_LOADING_ERR...");
          }
        });
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomImage(
                height: 70.0,
                width: 70.0,
                imgPath: "assets/images/app_logo.png"),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Simple Recharge",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: AppColors.secondary,
                        fontFamily: 'Sansation',
                        fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
