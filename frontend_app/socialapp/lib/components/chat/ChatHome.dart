import 'package:flutter/material.dart';
import 'package:socialapp/components/chat/elements/OneChat.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List listMessage = [];
  var messageDelete;
  var messageIdDelete;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 30; i++)
      listMessage.add(OneChat(
        avatarUrl: 'https://www.gstatic.com/webp/gallery/5.jpg',
        userName: 'This is user name',
        chatId: i,
        callback: deleteMessage,
      ));
  }

  deleteMessage(int messageId) {
    this.messageDelete = this.listMessage.elementAt(messageId);
    this.messageIdDelete = messageId;
    setState(() {
      this.listMessage.replaceRange(
          messageId, messageId + 1, [Container()]); //value is old widget
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      content: Text(
        'Deleted notify',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
      ),
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.green,
        onPressed: () {
          reverseAction();
        },
      ),
    ));
  }

  reverseAction() {
    setState(() {
      this.listMessage.replaceRange(
          this.messageIdDelete, this.messageIdDelete + 1, [this.messageDelete]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Message',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Candice',
              fontSize: 19,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        shadowColor: Colors.white,
        brightness: Brightness.light,
        // backgroundColor: Colors.black,
      ),
      body: ListView(
        //convert to AnimatedList
        children: [for (var item in listMessage) item],
      ),
    );
  }
}
