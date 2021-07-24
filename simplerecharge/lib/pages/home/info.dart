import 'package:flutter/material.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simplerecharge/services/ad_helper_service.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
        title:
            Text('Info', style: TextStyle(fontSize: 18.0, color: Colors.white)),
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
          Text(
              "Simple Recharge is an application build to top-up your SIM prepaid. The application protects your privacy and security so you don't need to worry about the safety of your information. Enjoy the hassle-free experience of the application. Simple Recharge is completely free to use application. You can top up your SIM as many times as you want.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14.0, color: Colors.black)),
          SizedBox(height: 15.0),
          Text("How to use the Simple Recharge application",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Download and launch the Simple Recharge app.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text("Allow app permissions to phone to enable the functions.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text("Select the SIM that you want to recharge.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text("Allow the camera permissions to open the phone camera.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(
                  "Take a photo of the scratched recharge card. Make sure to scratch the recharge card clearly and the quality of the photo.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(
                  "Simple recharge take some moment to identify the recharge number of your card.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(
                  "After successful identification of the recharge number, Simple Recharge will direct you to your dial pad.",
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              SizedBox(height: 5.0),
              Text(
                  "Feel free to confirm the recharge number shown in your dial pad and do the recharge",
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
