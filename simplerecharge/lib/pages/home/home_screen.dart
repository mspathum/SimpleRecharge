import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simplerecharge/constants/app_const.dart';
import 'package:simplerecharge/pages/home/info.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';
import 'package:simplerecharge/widgets/app_widgets/home_background.dart';
import 'package:simplerecharge/widgets/sim/sim_card.dart';
import 'package:simplerecharge/utils/message_dialog.dart';
import 'package:simplerecharge/pages/home/notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplerecharge/utils/url_launcher.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:simplerecharge/services/firebase_ml_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appState = getIt.get<AppState>();
  var drawerKey = GlobalKey<SwipeDrawerState>();
  bool isLoading = false;

  late File image;
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> getImage() async {
    var pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      image = File(pickedFile!.path);
    });
  }

  Future<void> captureImageWithCamera(String carrierName) async {
    try {
      setState(() {
        isLoading = true;
      });
      // PickedFile? pickedFile =
      //     await imagePicker.getImage(source: ImageSource.camera);
      // image = File(pickedFile?.path);
      getImage();
      String result = await FirebaseMLService.recogniseText(image);
      print("++++++++++++++++++");
      print(result);
      print("++++++++++++++++++");

      List<String> splitedList = result.split('\n');
      String rechargeNumber;
      int? cardNumLength;

      print("carrierName >>> $carrierName");
      if (carrierName == "airtel") {
        cardNumLength = 16;
      } else if (carrierName == "Dialog") {
        cardNumLength = 12;
      } else if (carrierName == "Mobitel") {
        cardNumLength = 14;
      } else if (carrierName == "Hutch") {
        cardNumLength = 14;
      } else if (carrierName == "Etisalat") {
        cardNumLength = 14;
      }

      final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
      rechargeNumber = splitedList.firstWhere((element) =>
          numericRegex.hasMatch(element) && element.length == cardNumLength);
      print("rechargeNumber >>> $rechargeNumber");
      setState(() {
        isLoading = false;
      });

      openDialpad(carrierName, rechargeNumber);
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showMessageDialog(context, "Error", "Failed to identify card details.");
    }
  }

  Future<void> openDialpad(String carrierName, String rechargeNumber) async {
    try {
      late String carrierPrefix;
      String hash;
      String? rechargeCode;

      if (Platform.isAndroid) {
        hash = "%23";
      } else {
        hash = "#";
      }

      if (carrierName == "airtel") {
        carrierPrefix = "*567" + hash;
      } else if (carrierName == "Dialog") {
        carrierPrefix = hash + "123" + hash;
      } else if (carrierName == "Mobitel") {
        carrierPrefix = "*102*";
      } else if (carrierName == "Hutch") {
        carrierPrefix = "*355*";
      } else if (carrierName == "Etisalat") {
        carrierPrefix = "*120*";
      }

      print("carrierName >>> $carrierName");
      print("carrierPrefix >>> $carrierPrefix");
      print("rechargeNumber >>> $rechargeNumber");
      print("rechargeCode >>> $rechargeCode");
      rechargeCode = carrierPrefix + rechargeNumber + hash;

      launch("tel://$rechargeCode");
    } catch (err) {
      showMessageDialog(context, "Error", "Failed to open Dialpad.");
    }
  }

  Widget buildDrawer() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
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
                "  Simple \nRecharge",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation',
                    color: AppColors.primary),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ListTile(
            leading:
                Icon(Icons.lightbulb_outline, color: Colors.white, size: 22.0),
            title: Text('Info',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined,
                color: Colors.white, size: 24.0),
            title: Text('Notifications',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          ListTile(
            leading:
                Icon(Icons.thumb_up_outlined, color: Colors.white, size: 22.0),
            title: Text('Rate Us',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            onTap: () {
              launchURL(
                  context, Platform.isAndroid ? PLAYSTORE_PATH : APPSTORE_PATH);
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.white, size: 24.0),
            title: Text('Support',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            onTap: () {
              launchURL(
                  context, Platform.isAndroid ? PLAYSTORE_PATH : APPSTORE_PATH);
            },
          ),
          SizedBox(height: 25.0),
          Center(
            child: Text(
                Platform.isAndroid
                    ? 'Version $ANDROID_VERSION'
                    : 'Version $IOS_VERSION',
                style: TextStyle(fontSize: 12.0, color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primary,
          leading: GestureDetector(
              onTap: () {
                if (drawerKey.currentState!.isOpened()) {
                  drawerKey.currentState!.closeDrawer();
                } else {
                  drawerKey.currentState!.openDrawer();
                }
              },
              child: Icon(Icons.menu_outlined, color: Colors.white)),
        ),
        Expanded(
          child: Container(
            color: AppColors.backgroundColor,
            child: Stack(
              children: [
                ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      color: AppColors.primary,
                    )),
                Column(
                  children: [
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: CustomImage(
                          height: 70.0,
                          width: 70.0,
                          imgPath: "assets/images/app_logo.png"),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Text(
                        "Simple Recharge",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                            color: AppColors.secondary),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimCardWidget(
                            "SIM 1",
                            appState.simCardsList[0].displayName,
                            captureImageWithCamera),
                        appState.simCardsList.length != 1
                            ? SimCardWidget(
                                "SIM 2",
                                appState.simCardsList[1].displayName,
                                captureImageWithCamera)
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.primary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.secondary),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,
        hasClone: false,
        bodyBackgroundPeekSize: 30,
        backgroundColor: AppColors.secondary,
        drawer: buildDrawer(),
        child: buildBody(),
      ),
    );
  }
}
