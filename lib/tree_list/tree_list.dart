import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';

class TreeListPage extends StatefulWidget {
  const TreeListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TreeListPageState createState() => _TreeListPageState();
}

class _TreeListPageState extends State<TreeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Container(
        child: CommentTreeWidget<Comment, Comment>(
          Comment(
              avatar: 'null', userName: 'null', content: 'This is comment 1'),
          [
            Comment(
              avatar: 'null',
              userName: 'null',
              content: 'This is comment 2',
            ),
          ],
          treeThemeData:
              TreeThemeData(lineColor: Colors.grey[500]!, lineWidth: 2),
          avatarRoot: (context, data) => const PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.orange,
              ),
            ),
            preferredSize: Size.fromRadius(8),
          ),
          avatarChild: (context, data) => const PreferredSize(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),
            preferredSize: Size.fromRadius(10),
          ),
          contentChild: (context, data) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'Test',
                style: Theme.of(context).textTheme.caption?.copyWith(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    'dangngocduc',
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
        padding: const EdgeInsets.all(40),
      ),
    );
  }
}
