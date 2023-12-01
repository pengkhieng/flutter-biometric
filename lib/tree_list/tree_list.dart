import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
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
      body: Column(
        children: [
          Container(
            child: CommentTreeWidget<Comment, Comment>(
              Comment(
                avatar: '',
                userName: '',
                content: 'អគ្គនាយកដ្ឋាន រដ្ឋបាល',
              ),
              [
                Comment(
                  avatar: '',
                  userName: '',
                  content: 'នាយកដ្ឋានបុគ្គលិកនិងបណ្តុះបណ្តាល',
                )
              ],
              treeThemeData:
                  TreeThemeData(lineColor: Colors.grey[500]!, lineWidth: 2),
              avatarRoot: (context, data) => const PreferredSize(
                child: Padding(
                  padding: EdgeInsets.only(bottom: .0, left: 8),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.orange,
                  ),
                ),
                preferredSize: Size.fromRadius(12),
              ),
              avatarChild: (context, data) => const PreferredSize(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 12.0, left: 8, right: 4, bottom: 0),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.orange,
                  ),
                ),
                preferredSize: Size.fromRadius(15),
              ),
              contentChild: (context, data) {
                return Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '${data.content}',
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
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
            padding: const EdgeInsets.only(left: 24, top: 20),
          ),
          Container(
            child: CommentTreeWidget<Comment, Comment>(
              Comment(
                avatar: '',
                userName: '',
                content: '',
              ),
              [
                Comment(
                  avatar: '',
                  userName: '1',
                  content: 'ការិយាល័យបច្ចេកទេសព័ត៌មានវិទ្យា',
                ),
                Comment(
                  avatar: '',
                  userName: '',
                  content: 'ការិយាល័យធនធានមនុស្ស',
                ),
              ],
              treeThemeData:
                  TreeThemeData(lineColor: Colors.grey[500]!, lineWidth: 2),
              avatarRoot: (context, data) => const PreferredSize(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.0, left: 0, top: 0),
                  // child: CircleAvatar(
                  //   radius: 5,
                  //   backgroundColor: Colors.orange,
                  // ),
                ),
                preferredSize: Size.fromRadius(15),
              ),
              avatarChild: (context, data) => const PreferredSize(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 4, top: 8, right: 0, bottom: 4),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.green,
                  ),
                ),
                preferredSize: Size.fromRadius(12),
              ),
              contentChild: (context, data) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 0),
                  child: Row(
                    children: [
                      Text(
                        '${data.content}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Spacer(),
                      if (data.userName != '')
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              '${data.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
              contentRoot: (context, data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      // child: Text(
                      //   'dangngocduc',
                      //   style: Theme.of(context).textTheme.caption?.copyWith(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w700,
                      //       color: Colors.black),
                      // ),
                    ),
                  ],
                );
              },
            ),
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 0),
          ),
        ],
      ),
    );
  }
}
