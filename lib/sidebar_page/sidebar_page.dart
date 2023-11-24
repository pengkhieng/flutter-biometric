import 'package:biolocalauth/widget/button_widget.dart';
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
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("Side Bar"),
        ),
        // body: Builder(
        //   builder: (context) => Container(
        //     alignment: Alignment.center,
        //     padding: EdgeInsets.symmetric(horizontal: 32),
        //     child: ButtonWidget(
        //       icon: Icons.open_in_new,
        //       text: 'Open Drawer',
        //       onClicked: () {
        //         Scaffold.of(context).openDrawer();
        //         // Scaffold.of(context).openEndDrawer();
        //       },
        //     ),
        //   ),
        // ),
      );
}
