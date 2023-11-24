import 'package:biolocalauth/custom_pin_keyboard.dart/custom_pin_keyboard.dart';
import 'package:biolocalauth/home_page2/home_page_controller2.dart';
import 'package:biolocalauth/sidebar_page/sidebar_page.dart';
import 'package:biolocalauth/tree_list/tree_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.lazyPut(() => HomePageController2());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      // home: CustomPinKeyBoard(),
      // home: TreeListPage(title: 'Tree Comment'),
      home: SideBarPage(),
    );
  }
}
