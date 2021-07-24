import 'dart:io';

class AdHelperService {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //test bannerId ca-app-pub-3940256099942544/6300978111
      return 'ca-app-pub-4250202272551487/2293173302';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
