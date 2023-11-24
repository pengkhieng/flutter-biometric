import 'package:biolocalauth/enum/enum.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:local_auth/local_auth.dart';

class HomePageController2 extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  Future<void> checkBiometrics() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (this.isClosed) return;

    canCheckBiometrics = canCheckBiometrics;
    update();
  }

  Future<void> getAvailableBiometrics() async {
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (this.isClosed) return;

    availableBiometrics = availableBiometrics;
    update();
  }

  Future<void> authenticate() async {
    // this use biometrics or pin code
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      isAuthenticating = false;
      update();
    } on PlatformException catch (e) {
      print(e);
      isAuthenticating = false;
      authorized = 'Error - ${e.message}';
      update();
      return;
    }
    if (this.isClosed) return;

    () => authorized = authenticated ? 'Authorized' : 'Not Authorized';
    update();
  }

  Future<void> authenticateWithBiometrics() async {
    // only Biometrics
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
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    () => isAuthenticating = false;
    update();
  }
}
