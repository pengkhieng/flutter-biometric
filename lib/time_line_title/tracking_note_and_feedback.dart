import 'package:biolocalauth/time_line_title/timeline_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timelines/timelines.dart';

class Tracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          final data = _data(index + 1);
          return Container(
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: _DeliveryProcesses(processes: data.deliveryProcesses),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
  });

  final List<_DeliveryMessage> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                thickness: 1.0,
              ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 10.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
              !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(messages[index - 1].toString()),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
              isEdgeIndex(index) ? true : null,
          itemCount: messages.length + 2,
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.green,
        fontSize: 12.5,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Colors.green,
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      processes[index].name, // put title here
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18.0,
                          ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.green,
                    )
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (processes[index].isCompleted) {
                return DotIndicator(
                  size: 24,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      SvgAsset.security_fill_icon,
                      // width: 24,
                      color: Color.fromARGB(255, 2, 112, 209),
                    ),
                  ),
                );
              } else {
                return DotIndicator(
                  size: 24,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(14)),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: processes[index].isCompleted ? Colors.green : null,
            ),
          ),
        ),
      ),
    );
  }
}

_OrderInfo _data(int id) => _OrderInfo(
      id: id,
      deliveryProcesses: [
        _DeliveryProcess(
          'ស្ថានភាពឯកសារបច្ចុប្បន្ន',
          'អ៊ួង សុភា, ប្រធាននាយកដ្ឋាន',
          'នាយកដ្ឋានគោលនយោបាយផ្កាយរណប',
          messages: [
            _DeliveryMessage('អ៊ួង សុភា', 'ប្រធាននាយកដ្ឋាន'),
          ],
        ),
        _DeliveryProcess(
          'បង្កើតដោយ',
          'ឡេង ចំណាន, អគ្គនាយក​',
          'អគ្គនាយកដ្ឋានគោលនយោបាយផ្កាយរណប​',
          messages: [
            _DeliveryMessage('អ៊ួង សុភា', 'ប្រធាននាយកដ្ឋាន'),
          ],
        ),
        _DeliveryProcess(
          'បង្កើតដោយ',
          'ឡេង ចំណាន, អគ្គនាយក​',
          'អគ្គនាយកដ្ឋានគោលនយោបាយផ្កាយរណប​',
          messages: [
            _DeliveryMessage('អ៊ួង សុភា', 'ប្រធាននាយកដ្ឋាន'),
          ],
        ),
      ],
    );

class _OrderInfo {
  const _OrderInfo({
    required this.id,
    required this.deliveryProcesses,
  });

  final int id;
  final List<_DeliveryProcess> deliveryProcesses;
}

class _DriverInfo {
  const _DriverInfo({
    required this.name,
    required this.desc,
  });

  final String name;
  final String desc;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name,
    this.desc,
    this.desc1, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : this.name = 'Done',
        this.desc = 'desc',
        this.desc1 = 'desc1',
        this.messages = const [];

  final String name;
  final String desc;
  final String desc1;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}
