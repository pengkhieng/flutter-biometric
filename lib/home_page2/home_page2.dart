import 'package:biolocalauth/enum/enum.dart';
import 'package:biolocalauth/error_page/error_page.dart';
import 'package:biolocalauth/home_page2/home_page_controller2.dart';
import 'package:biolocalauth/next_page/next_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  HomePageController2 _controller = Get.find<HomePageController2>();
  @override
  void initState() {
    super.initState();
    _controller.auth.isDeviceSupported().then(
          (bool isSupported) => setState(
            () => _controller.supportState =
                isSupported ? SupportState.supported : SupportState.unsupported,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: ListView(
              padding: const EdgeInsets.only(top: 30),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (controller.supportState == SupportState.unknown)
                      const CircularProgressIndicator()
                    else if (controller.supportState == SupportState.supported)
                      const Text('This device is supported')
                    else
                      const Text('This device is not supported'),
                    const Divider(height: 100),
                    Text(
                        'Can check biometrics: ${controller.canCheckBiometrics}\n'),
                    ElevatedButton(
                      onPressed: controller.checkBiometrics,
                      child: const Text('Check biometrics'),
                    ),
                    const Divider(height: 100),
                    Text(
                        'Available biometrics: ${controller.availableBiometrics}\n'),
                    ElevatedButton(
                      onPressed: () {
                        controller.getAvailableBiometrics();
                      },
                      child: const Text('Get available biometrics'),
                    ),
                    const Divider(height: 100),
                    Text('Current State: ${controller.authorized}\n'),
                    if (controller.isAuthenticating)
                      ElevatedButton(
                        onPressed: () {
                          print('Hello');
                        },
                        // onPressed: controller.cancelAuthentication,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text('Cancel Authentication'),
                            Icon(
                              Icons.cancel,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              await controller.authenticateWithBiometrics();

                              if (controller.authorized == 'Authorized') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NextPage(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ErrorPage(),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(controller.isAuthenticating
                                    ? 'Cancel'
                                    : 'Authenticate: biometrics only'),
                                const Icon(Icons.fingerprint),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
