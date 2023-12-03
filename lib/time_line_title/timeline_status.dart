import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 100.0;

class TimelineStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              _Timeline1(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Timeline1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = _TimelineStatus.values;
    return Flexible(
      child: Timeline.tileBuilder(
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
        padding: EdgeInsets.symmetric(vertical: 20.0),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_, __) => _EmptyContents(),
          connectorBuilder: (_, index, __) {
            if (index == 0) {
              return DashedLineConnector(
                color: Colors.grey,
              );
            } else {
              return SolidLineConnector(
                color: Colors.green,
              );
            }
          },
          indicatorBuilder: (_, index) {
            switch (data[index]) {
              case _TimelineStatus.done:
                return DotIndicator(
                  color: Color(0xff6ad192),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10.0,
                  ),
                );
              case _TimelineStatus.sync:
                return DotIndicator(
                  color: Color(0xff6ad192),
                  child: Icon(
                    Icons.check,
                    size: 10.0,
                    color: Colors.white,
                  ),
                );
              case _TimelineStatus.inProgress:
                return DotIndicator(
                  color: Color(0xff6ad192),
                  child: Icon(
                    Icons.check,
                    size: 10.0,
                    color: Colors.white,
                  ),
                );
              case _TimelineStatus.todo:
              default:
                return
                    // OutlinedDotIndicator(
                    //   color: Colors.green,
                    //   backgroundColor: Colors.orange,
                    // );
                    Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.red,
                  ),
                );
            }
          },
          itemExtentBuilder: (_, __) => kTileHeight,
          itemCount: data.length,
        ),
      ),
    );
  }
}

class _EmptyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.yellow,
      ),
    );
  }
}

enum _TimelineStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}
