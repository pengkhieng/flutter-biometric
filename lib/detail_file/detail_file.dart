import 'package:biolocalauth/time_line_title/timeline_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timelines/timelines.dart';

class DetailFile extends StatelessWidget {
  const DetailFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.withOpacity(0.2),
        padding: EdgeInsets.all(20),
        child: TimelineDetail(),
      ),
    );
  }
}

// double kTileHeight = 80;

class TimelineDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = _TimelineStatus.values;
    return Container(
      child: Timeline.tileBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        theme: TimelineThemeData(
          nodePosition: 0,
          connectorTheme: ConnectorThemeData(
            thickness: 3.0,
            color: Colors.green,
          ),
          indicatorTheme: IndicatorThemeData(
            size: 20.0,
          ),
        ),
        // padding: EdgeInsets.symmetric(vertical: 20.0),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_, index) {
            if (index == 2) {
              return Container();
            } else {
              return _EmptyContents();
            }
          },
          connectorBuilder: (_, index, __) {
            return DashedLineConnector(
              color: Colors.grey,
            );
          },
          indicatorBuilder: (_, index) {
            switch (data[index]) {
              case _TimelineStatus.done:
                return _buildStatusIndicator(Colors.blue);
              // case _TimelineStatus.sync:
              //   return _buildStatusIndicator(Colors.blue);
              case _TimelineStatus.inProgress:
                return _buildStatusIndicator(Colors.blue);
              case _TimelineStatus.todo:
              default:
                return Container(
                  width: 35,
                );
            }
          },
          // itemExtentBuilder: (_, index) {
          //   if (index == data.length - 1) {
          //     return 1;
          //   } else {
          //     return kTileHeight;
          //   }
          // },
          itemCount: data.length,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(Color color) {
    return Container(
      padding: EdgeInsets.all(6),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
      ),
      child: SvgPicture.asset(
        SvgAsset.security_fill_icon,
        width: 32,
        color: Colors.white,
      ),
    );
  }
}

class _EmptyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 10),
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.blue,
      ),
      child: Column(
        children: [
          Text("data"),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}

enum _TimelineStatus {
  done,
  inProgress,
  todo,
}
