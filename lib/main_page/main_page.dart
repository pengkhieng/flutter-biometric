import 'package:biolocalauth/Animation/animation_splash_screen.dart';
import 'package:biolocalauth/Internet_connection/internet_connection.dart';
import 'package:biolocalauth/custom_buttom/custom_buttom.dart';
import 'package:biolocalauth/custom_pin_keyboard.dart/custom_pin_keyboard.dart';
import 'package:biolocalauth/detail_file/detail_file.dart';
import 'package:biolocalauth/pdf_thumbnail/pdf_thumbnail.dart';
import 'package:biolocalauth/pdf_view/pdf_view.dart';
import 'package:biolocalauth/time_line_title/package_delivery_tracking.dart';
import 'package:biolocalauth/time_line_title/timeline_status.dart';
import 'package:biolocalauth/time_line_title/tracking_note_and_feedback.dart';
import 'package:biolocalauth/tree_list/tree_list.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.cloud_outlined)),
              Tab(icon: Icon(Icons.beach_access_sharp)),
              // Tab(icon: Icon(Icons.brightness_5_sharp)),
              // Tab(icon: Icon(Icons.camera)),
              // Tab(icon: Icon(Icons.sunny)),
              // Tab(icon: Icon(Icons.color_lens)),
              // Tab(icon: Icon(Icons.animation)),
              // // Tab(icon: Icon(Icons.ac_unit_rounded)),
              // Tab(icon: Icon(Icons.picture_as_pdf)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tracking(),
            // PackageDeliveryTrackingPage(),
            // TimelineStatusPage(),
            // DetailFile(),
            // TreeListPage(),
            CustomBtn(),
            // AnimatedPositionedImage(),
            // InternetConnection(),
            // PdfViewPage(),
            // PdfViewPage(),
            CustomPinKeyBoard()
          ],
        ),
      ),
    );
  }
}
