import 'package:biolocalauth/enum/enum.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class CustomPinKeyboardController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;
  bool enableBiometric = false;
  bool light = false;

  Future<void> checkBiometrics() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      enableBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      enableBiometric = false;
      print(e);
    }
    if (this.isClosed) return;

    update();
  }

  Future<void> authenticateWithBiometrics({VoidCallback? onBioIsMatch}) async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      isAuthenticating = false;
      authorized = 'Authenticating';
      update();
    } on PlatformException catch (e) {
      print(e);
      isAuthenticating = false;
      authorized = 'Error - ${e.message}';
      update();
      return;
    }
    if (this.isClosed) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    authorized = message;
    update();
    if (authenticated) {
      if (onBioIsMatch != null) {
        onBioIsMatch!();
      } else {
        print('No route');
      }
      update();
    }
  }
}
