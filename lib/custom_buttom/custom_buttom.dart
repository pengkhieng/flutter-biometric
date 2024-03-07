import 'package:biolocalauth/custom_pin_keyboard.dart/custom_pin_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class CustomBtn extends StatefulWidget {
  const CustomBtn({super.key});

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withOpacity(0.1),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.dialog(
                  WillPopScope(
                    onWillPop: () async => false,
                    child: CustomPinKeyBoard(
                      onPinIsMatch: () {
                        print("much pin from main screen");
                      },
                    ),
                  ),
                  barrierDismissible: false,
                  useSafeArea: false,
                );
              },
              child: Container(
                // color: Colors.red,
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Tap Here',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                // decoration: BoxDecoration(
                //     color: Colors.blue,
                //     borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Tap Here',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
