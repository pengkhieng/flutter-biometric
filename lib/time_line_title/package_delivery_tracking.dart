import 'package:biolocalauth/time_line_title/timeline_status.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timelines/timelines.dart';

class PackageDeliveryTrackingPage extends StatelessWidget {
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
                  // padding: const EdgeInsets.only(top: 10.0),
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

// class _OrderTitle extends StatelessWidget {
//   const _OrderTitle({
//     Key? key,
//     required this.orderInfo,
//   }) : super(key: key);

//   final _OrderInfo orderInfo;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           'Delivery #${orderInfo.id}',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Spacer(),
//         Text(
//           '${orderInfo.date.day}/${orderInfo.date.month}/${orderInfo.date.year}',
//           style: TextStyle(
//             color: Color(0xffb6b2b2),
//           ),
//         ),
//       ],
//     );
//   }
// }

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
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
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
                      child: CommentTreeWidget<Comment, Comment>(
                        Comment(
                          avatar: '',
                          userName: '',
                          content: processes[index].desc,
                        ),
                        [
                          Comment(
                            avatar: '',
                            userName: '',
                            content: processes[index].desc1,
                          )
                        ],
                        treeThemeData: TreeThemeData(
                            lineColor: Colors.grey[500]!, lineWidth: 2),
                        avatarRoot: (context, data) => const PreferredSize(
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: .0, left: 4, top: 4),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.orange,
                            ),
                          ),
                          preferredSize: Size.fromRadius(10),
                        ),
                        avatarChild: (context, data) => const PreferredSize(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, left: 8, right: 4, bottom: 0),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.green,
                            ),
                          ),
                          preferredSize: Size.fromRadius(18),
                        ),
                        contentChild: (context, data) {
                          return Container(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                            ),
                          );
                        },
                        contentRoot: (context, data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                child: Text(
                                  '${data.content}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      padding: const EdgeInsets.only(top: 12),
                    ),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (index == 2) {
                return Container();
              } else if (processes[index].isCompleted) {
                return DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                // return OutlinedDotIndicator(
                //   borderWidth: 2.5,
                // );
                return DotIndicator(
                  size: 40,
                  color: const Color.fromARGB(255, 203, 202, 202),
                  child:
                      //  Icon(
                      //   Icons.check,
                      //   color: Colors.yellow,
                      //   size: 12.0,
                      // ),
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      SvgAsset.security_fill_icon,
                      width: 24,
                      color: Color.fromARGB(255, 2, 112, 209),
                    ),
                  ),
                );
              }
            },
            connectorBuilder: (_, index, ___) => DashedLineConnector(
              color: processes[index].isCompleted ? Colors.grey : null,
            ),
          ),
        ),
      ),
    );
  }
}

// class _OnTimeBar extends StatelessWidget {
//   const _OnTimeBar({Key? key, required this.driver}) : super(key: key);

//   final _DriverInfo driver;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         MaterialButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('On-time!'),
//               ),
//             );
//           },
//           elevation: 0,
//           shape: StadiumBorder(),
//           color: Color(0xff66c97f),
//           textColor: Colors.white,
//           child: Text('On-time'),
//         ),
//         Spacer(),
//         Text(
//           'Driver\n${driver.name}',
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(width: 12.0),
//         Container(
//           width: 40.0,
//           height: 40.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               fit: BoxFit.fitWidth,
//               image: NetworkImage(
//                 driver.thumbnailUrl,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

_OrderInfo _data(int id) => _OrderInfo(
      id: id,
      deliveryProcesses: [
        _DeliveryProcess(
          'ស្ថានភាពឯកសារបច្ចុប្បន្ន',
          'ប្រធាននាយកដ្ឋាន',
          'នាយកដ្ឋានគោលនយោបាយផ្កាយរណប',
          messages: [
            _DeliveryMessage('ប្រធាននាយកដ្ឋាន សុភា', 'ប្រធាននាយកដ្ឋាន'),
          ],
        ),

        _DeliveryProcess(
          'បង្កើតដោយ',
          'អគ្គនាយក​',
          'អគ្គនាយកដ្ឋានគោលនយោបាយផ្កាយរណប​',
          messages: [
            _DeliveryMessage('ប្រធាននាយកដ្ឋាន សុភា', 'ប្រធាននាយកដ្ឋាន'),
          ],
        ),
        _DeliveryProcess.complete(),
        // _DeliveryProcess.complete(),
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

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}
