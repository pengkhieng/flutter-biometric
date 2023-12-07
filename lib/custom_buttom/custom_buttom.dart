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
        // child: InkWell(
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.orange,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 100,
        //       vertical: 40,
        //     ),
        //     child: Text(
        //       'Done',
        //       style: TextStyle(
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white,
        //         fontSize: 22,
        //       ),
        //     ),
        //   ),
        //   hoverColor: Colors.red,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
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
