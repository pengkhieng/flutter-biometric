import 'package:biolocalauth/time_line_title/package_delivery_tracking.dart';
import 'package:biolocalauth/time_line_title/process_timeline.dart';
import 'package:biolocalauth/time_line_title/time_line_title.dart';
import 'package:biolocalauth/time_line_title/timeline_status.dart';
import 'package:biolocalauth/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(title: Text('Custom Text')),
        // body: TimelinePage(),
        body: PackageDeliveryTrackingPage(),
        // body: ProcessTimelinePage(),
        // body: TimelineStatusPage(),
      );
}
