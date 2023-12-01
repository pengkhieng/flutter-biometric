import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            TimelineTile(
              afterLineStyle: LineStyle(
                color: Colors.green,
              ),
              isFirst: true,
              lineXY: 0.1,
              alignment: TimelineAlign.manual,
              indicatorStyle: IndicatorStyle(
                width: 24,
                height: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                drawGap: true,
                indicator: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '42',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              endChild: Column(
                children: [
                  Container(
                    color: Colors.pink,
                    height: 20,
                  ),
                ],
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1, // Adjust the lineX value as needed
              // indicatorStyle: const IndicatorStyle(
              //   width: 20,
              //   color: Colors.red,
              // ),
              beforeLineStyle: const LineStyle(
                color: Colors.green,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.green,
              ),
              indicatorStyle: IndicatorStyle(
                width: 24,
                height: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                drawGap: true,
                indicator: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '52',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TimelineTile(
              isLast: true,
              alignment: TimelineAlign.manual,
              lineXY:
                  0.1, // You can adjust this value based on your layout needs
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: Colors.red,
                iconStyle: IconStyle(iconData: Icons.done),
              ),
              beforeLineStyle: LineStyle(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
