import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/components/chat/ChatUser.dart';
import 'package:socialapp/popup/sheetBottom/bottomSheet.dart';

class OneChat extends StatefulWidget {
  String avatarUrl;
  String userName;
  final int chatId;
  Function callback;

  OneChat({Key key, this.avatarUrl, this.userName, this.chatId, this.callback})
      : super(key: key);
  @override
  _OneChatState createState() => _OneChatState();
}

class _OneChatState extends State<OneChat> {
  String newestMess =
      'This is a message very long very very long bla bla bla bla long long long long long long long long lkjahskdjha akjshdkashd askdjhaskdj';
  bool isRead = Random().nextBool();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userName = widget.userName;
    return Card(
      borderOnForeground: false,
      elevation: 0.0,
      color: Colors.black,
      margin: EdgeInsets.all(0),
      child: ListTile(
        onTap: () {
          setState(() {
            this.isRead = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatUser(),
            ),
          );
        },
        onLongPress: () {
          showSlideBottomSheet(context, listOptions: [
            singleOption(
              'Delete message',
              context: context,
              iconOption: FontAwesomeIcons.trash,
              callbackFunction: () {
                Navigator.pop(context);
                widget.callback(widget.chatId);
              },
            )
          ]);
        },
        contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            border: Border.all(
              color: Colors.amber[800],
            ),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(widget.avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          '$userName',
          style: TextStyle(
            color: !isRead ? Colors.white : Colors.white54.withOpacity(0.6),
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '$newestMess',
            style: TextStyle(
              color: !isRead ? Colors.white : Colors.white54.withOpacity(0.6),
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
