import 'package:biolocalauth/page/user_page.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: name,
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  Container(
                    child: buildMenuItem(
                      text: 'Plugins',
                      icon: Icons.account_tree_outlined,
                    ),
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      child: buildMenuItem(
                        text: 'Notifications',
                        icon: Icons.notifications_outlined,
                      ),
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    child: CommentTreeWidget<Comment, Comment>(
                      Comment(
                        avatar: 'null',
                        userName: 'null',
                        content: 'This is comment 1',
                      ),
                      [
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                        Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: 'This is comment 2',
                        ),
                      ],
                      treeThemeData: TreeThemeData(
                          lineColor: Colors.grey[500]!, lineWidth: 2),
                      avatarRoot: (context, data) => const PreferredSize(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          // child: CircleAvatar(
                          //   radius: 5,
                          //   backgroundColor: Colors.orange,
                          // ),
                        ),
                        preferredSize: Size.fromRadius(15),
                      ),
                      avatarChild: (context, data) => const PreferredSize(
                        child: Padding(
                          padding: EdgeInsets.all(0.0),
                          // child: CircleAvatar(
                          //   radius: 5,
                          //   backgroundColor: Colors.green,
                          // ),
                        ),
                        preferredSize: Size.fromRadius(15),
                      ),
                      contentChild: (context, data) {
                        return GestureDetector(
                          onTap: () {
                            print('ចែករំលែកលំហូរមកខ្មុំ');
                          },
                          child: Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Text(
                              'ចែករំលែកលំហូរមកខ្មុំ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                            ),
                          ),
                        );
                      },
                      contentRoot: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              // child: Text(
                              //   'dangngocduc',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .caption
                              //       ?.copyWith(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w700,
                              //           color: Colors.black),
                              // ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
