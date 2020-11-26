import 'dart:math';

import 'package:flutter/material.dart';
import 'package:socialapp/reuseComponents/ClipIconButton.dart';

class ChatUser extends StatefulWidget {
  final String chatId;
  final String userId;

  const ChatUser({Key key, this.chatId, this.userId}) : super(key: key);
  @override
  _ChatUserState createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  String avatarUrl = 'https://www.gstatic.com/webp/gallery/5.jpg';
  String userName = 'This is user name';

  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Container oneMessage(bool isOwner, Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: 15, right: 15, top: 8.0, bottom: 8.0),
      child: Align(
        alignment: isOwner ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          width: size.width * 0.6,
          child: Wrap(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[800]),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.only(left: 13, top: 8, bottom: 3, right: 13),
                    title: Text(
                      'this is a message saldkjlaskd laskdjlasd asldkjal alsdkj',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Text(
                        '23:41   19-10-2020',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: false,
        leadingWidth: 20,
        backgroundColor: Colors.black,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          title: Text(
            '$userName',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 19,
          ),
          for (int i = 0; i < 30; i++) oneMessage(Random().nextBool(), size)
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: TextFormField(
          controller: _textEditingController,
          style: TextStyle(
            fontSize: 18.0,
          ),
          showCursor: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 15.0, bottom: 3.0),
              suffix: singleClipOvalButton(
                backgroundColor: Colors.grey[400],
                icon: Icons.send,
                iconSize: 13,
                sizeButton: 18,
                callbackFunction: () {
                  _textEditingController.clear();
                },
                iconColor: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: Colors.white,

                )
              )
              // prefix: Icon(Icons.email),
              ),
          // validator: (value) {
          //   if (value.isEmpty) {
          //     // return 'This is not allow null';
          //     return null;
          //   }
          //   return null;
          // },
        ),
      ),
    );
  }
}
