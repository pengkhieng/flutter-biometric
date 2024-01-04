// import 'dart:async';

// import 'package:biolocalauth/Internet_connection/internet_connection_controller.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class InternetConnection extends StatefulWidget {
//   const InternetConnection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<InternetConnection> createState() => _InternetConnectionState();
// }

// class _InternetConnectionState extends State<InternetConnection> {
//   InternetController _internetController = Get.find<InternetController>();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   @override
//   void initState() {
//     super.initState();
//     _internetController.initConnectivity();

//     _connectivitySubscription = _internetController
//         .connectivity.onConnectivityChanged
//         .listen(_internetController.updateConnectionStatus);
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: _internetController,
//       builder: (controller) {
//         return Scaffold(
//           body: Center(
//             child: Text(
//               'Connection Status: ${controller.isConnection ? 'Is Connection Network' : 'No Connection Network'}',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 20,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
