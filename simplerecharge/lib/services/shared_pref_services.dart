import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final String lngRef = "lng";

  static String selectedLng = "en";

  static Future<void> getLngSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString(lngRef) ?? "en";
    selectedLng = result;
    print("---getLngSharedData----");
    print(selectedLng);
  }

  static Future<void> setLngSharedData(String lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(lngRef, lng);
    selectedLng = lng;
    print("---setLngSharedData----");
    print(selectedLng);
  }
}
