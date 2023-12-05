import 'package:comment_tree/comment_tree.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:flutter/material.dart';

class TreeListPage extends StatefulWidget {
  const TreeListPage({
    Key? key,
  }) : super(key: key);

  @override
  _TreeListPageState createState() => _TreeListPageState();
}

class _TreeListPageState extends State<TreeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: CommentTreeWidget<Comment, Comment>(
                Comment(
                  avatar: '',
                  userName: '',
                  content: 'អគ្គនាយកដ្ឋាន រដ្ឋបាល',
                ),
                itemss
                    .map((item) => Comment(
                          avatar: '',
                          userName: '',
                          content: '${item.name}',
                        ))
                    .toList(),
                treeThemeData:
                    TreeThemeData(lineColor: Colors.grey[500]!, lineWidth: 2),
                avatarRoot: (context, data) => const PreferredSize(
// Main Point  =================================================================================================================
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 0,
                      left: 4,
                    ),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  preferredSize: Size.fromRadius(12),
                ),
                avatarChild: (context, data) => const PreferredSize(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    // child: CircleAvatar(
                    //   radius: 5,
                    //   backgroundColor: Colors.green,
                    // ),
                  ),
                  preferredSize: Size.fromRadius(10),
                ),
                contentChild: (context, data) {
// Sub Coment  =================================================================================================================
                  return CommentTreeWidget<Comment, Comment>(
                    Comment(
                      avatar: '',
                      userName: '',
                      content: '${data.content}',
                    ),
                    items
                        .map((item) => Comment(
                              avatar: '',
                              userName: '',
                              content: '${item.name}',
                            ))
                        .toList(),
                    treeThemeData: TreeThemeData(
                        lineColor: Colors.grey[500]!, lineWidth: 2),
                    avatarRoot: (context, data) => const PreferredSize(
// Sub Main Point  =================================================================================================================
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, left: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                      preferredSize: Size.fromRadius(12),
                    ),
                    avatarChild: (context, data) => const PreferredSize(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, left: 8, right: 0, bottom: 0),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      preferredSize: Size.fromRadius(10),
                    ),
                    contentChild: (context, data) {
                      return Container(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          '${data.content}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                        ),
                      );
                    },
                    contentRoot: (context, data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 0),
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
                          ),
                        ],
                      );
                    },
                  );
// End Sub Coment  =================================================================================================================
                },
                contentRoot: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 0,
                        ),
// Main Comment  =================================================================================================================
                        child: Text(
                          '${data.content}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  final String name;

  Item(
    this.name,
  );
}

final List<Item> itemss = [
  Item('នាយកដ្ឋានបុគ្គលិកនិងបណ្តុះបណ្តាល'),
];
final List<Item> items = [
  Item('ការិយាល័យបច្ចេកទេសព័ត៌មានវិទ្យា'),
  Item('ការិយាល័យធនធានមនុស្ស'),
];
