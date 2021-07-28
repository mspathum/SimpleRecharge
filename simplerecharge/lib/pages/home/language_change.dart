import 'package:flutter/material.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';
import 'package:simplerecharge/services/shared_pref_services.dart';

class LangChangePage extends StatefulWidget {
  const LangChangePage({Key? key}) : super(key: key);

  @override
  _LangChangePageState createState() => _LangChangePageState();
}

class _LangChangePageState extends State<LangChangePage> {
  final appState = getIt.get<AppState>();

  bool isEnglish = SharedPrefService.selectedLng == "en" ? true : false;
  bool isSinhala = SharedPrefService.selectedLng == "si" ? true : false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(appState.getTranslation("lang_changed"),
            style: TextStyle(fontSize: 18.0, color: Colors.white)),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Column(
          children: [
            SizedBox(height: 15.0),
            Container(
              alignment: Alignment.topCenter,
              child: CustomImage(
                  height: 200.0,
                  width: 200.0,
                  imgPath: "assets/images/settings.png"),
            ),
            SizedBox(height: 15.0),
            Text(appState.getTranslation("change_app_lang"),
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 15.0),
            CheckboxListTile(
              title: Text(appState.getTranslation("english")),
              activeColor: AppColors.primary,
              value: isEnglish,
              onChanged: (bool? value) async {
                setState(() {
                  isEnglish = true;
                  isSinhala = false;
                });
                await SharedPrefService.setLngSharedData("en");
                setState(() {});
              },
            ),
            CheckboxListTile(
                title: Text(appState.getTranslation("sinhala")),
                activeColor: AppColors.primary,
                value: isSinhala,
                onChanged: (bool? value) async {
                  setState(() {
                    isSinhala = true;
                    isEnglish = false;
                  });
                  await SharedPrefService.setLngSharedData("si");
                  setState(() {});
                }),
            SizedBox(height: 10.0)
          ],
        ),
      ),
    );
  }
}
