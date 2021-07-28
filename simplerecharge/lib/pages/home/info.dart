import 'package:flutter/material.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simplerecharge/services/ad_helper_service.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final appState = getIt.get<AppState>();

  late BannerAd bannerAd;
  bool isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
      adUnitId: AdHelperService.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(appState.getTranslation("Info"),
            style: TextStyle(fontSize: 18.0, color: Colors.white)),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        child: Column(children: [
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.topCenter,
            child: CustomImage(
                height: 70.0,
                width: 70.0,
                imgPath: "assets/images/app_logo.png"),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Container(
              child: Text(
                "Simple Recharge",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation',
                    color: AppColors.primary),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Text(appState.getTranslation("Simple_Recharge_is_an_application"),
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14.0, color: Colors.black)),
          SizedBox(height: 15.0),
          Text(appState.getTranslation("How_to_use"),
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appState.getTranslation("step_1"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_2"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_3"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_4"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_5"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_6"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_7"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(appState.getTranslation("step_8"),
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
            ],
          ),
          SizedBox(height: 10.0),
          if (isBannerAdReady)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: AppColors.backgroundColor,
                width: bannerAd.size.width.toDouble(),
                height: bannerAd.size.height.toDouble(),
                child: AdWidget(ad: bannerAd),
              ),
            ),
          SizedBox(height: 10.0)
        ]),
      )),
    );
  }
}
