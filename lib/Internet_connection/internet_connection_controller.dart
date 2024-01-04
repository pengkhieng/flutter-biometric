import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  bool isConnection = false;
  final Connectivity connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } catch (e) {
      print('Couldn\'t check connectivity status : $e');
      return;
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      isConnection = true;
    } else {
      isConnection = false;
    }

    update();
  }
}
