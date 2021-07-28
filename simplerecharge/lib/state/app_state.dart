import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' as rootBundle;
import 'base/cube_state.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sim_data/sim_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simplerecharge/services/shared_pref_services.dart';

class AppState {
  var cStateAppState = new CubeState<int>(0);

  late final jsonData;

  List<SimCard> simCardsList = [];

  AppState() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      initApp();
    });
  }

  initApp() async {
    try {
      print("AppState init...");
      await initAssets();
      cStateAppState.setNext(1);
    } catch (err, stack1) {
      print(["initApp", err, stack1]);
      cStateAppState.setNext(-1);
    }
  }

  Future<void> initAssets() async {
    var data =
        await rootBundle.rootBundle.loadString('assets/translations.json');
    jsonData = json.decode(data);
    await SharedPrefService.getLngSharedData();
  }

  String getTranslation(String key) {
    return jsonData[key][SharedPrefService.selectedLng];
  }

  Future<void> getSimInfo() async {
    try {
      await Permission.phone.request();
      var status = await Permission.phone.status;
      print("status >>> ${status.isGranted}");
      if (status.isGranted) {
        SimData simData = await SimDataPlugin.getSimData();
        simCardsList = simData.cards;
        print("SIM_DATA_LOADED");
      } else {
        exit(0);
      }
    } catch (err) {
      print("APP_STATE_SIM_DATA_LOAD_ERR");
      throw err;
    }
  }
}
