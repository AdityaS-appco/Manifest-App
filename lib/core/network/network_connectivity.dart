import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  static Future<bool> checkInternet() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return true;
    }
    return false;
  }
}
