import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:get/get.dart';

class MentionInput extends StatefulWidget {
  @override
  _MentionInputState createState() => _MentionInputState();
}

class _MentionInputState extends State<MentionInput> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> users = [
      {'id': '61as61fsa', 'display': 'fayeedP', 'full_name': 'Fayeed Pawaskar'},
      {'id': '61as61fsb', 'display': 'johnD', 'full_name': 'John Doe'},
      {'id': '61as61fsc', 'display': 'janeS', 'full_name': 'Jane Smith'},
      {'id': '61as61fsd', 'display': 'aliceJ', 'full_name': 'Alice Johnson'},
      {'id': '61as61fse', 'display': 'bobW', 'full_name': 'Bob Williams'},
      {'id': '61as61fsf', 'display': 'emilyB', 'full_name': 'Emily Brown'},
      {'id': '61as61fsg', 'display': 'michaelD', 'full_name': 'Michael Davis'},
      {'id': '61as61fsh', 'display': 'oliviaG', 'full_name': 'Olivia Garcia'},
      {
        'id': '61as61fsi',
        'display': 'williamM',
        'full_name': 'William Martinez'
      },
      {
        'id': '61as61fsj',
        'display': 'sophiaR',
        'full_name': 'Sophia Rodriguez'
      },
    ];
    return Scaffold(
      body: Portal(
        child: FlutterMentions(
          onChanged: (value) {
            print('This is value: $value');
          },
          key: key,
          suggestionPosition: SuggestionPosition.Top,
          maxLines: 5,
          minLines: 5,
          decoration: InputDecoration(
              labelText: 'ugkhk',
              alignLabelWithHint: true,
              border: OutlineInputBorder()),
          mentions: [
            Mention(
              trigger: '@',
              style: TextStyle(
                color: Colors.green,
              ),
              data: users,
              matchAll: false,
              suggestionBuilder: (data) {
                return Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.green,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(data['full_name']),
                          Text('@${data['display']}'),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
