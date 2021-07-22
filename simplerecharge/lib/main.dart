import 'package:get_it/get_it.dart';
import './state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:simplerecharge/pages/loading/splash_screen.dart';
import 'package:simplerecharge/pages/loading/app_update.dart';
import 'package:simplerecharge/pages/home/home_screen.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppState>(AppState());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Recharge',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreenPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/appUpdate': (BuildContext context) => AppUpdatePage()
        });
  }
}
