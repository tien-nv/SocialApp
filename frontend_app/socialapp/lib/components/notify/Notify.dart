import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/notify/elements/OneNotify.dart';

class UserNotifications extends StatefulWidget {
  final String userId;

  const UserNotifications({Key key, @required this.userId}) : super(key: key);
  @override
  _UserNotificationsState createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  List<Widget> listNotifications;
  Widget notifyDelete;
  int notifyIdDelete;

  @override
  void initState() {
    super.initState();
    listNotifications = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  deleteNotify(int notifyId) {
    this.notifyDelete = this.listNotifications.elementAt(notifyId);
    this.notifyIdDelete = notifyId;
    setState(() {
      this.listNotifications.replaceRange(
          notifyId, notifyId + 1, [Container()]); //value is old widget
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.black.withOpacity(0.8),
      content: Text(
        'Deleted notify',
        style: TextStyle(
          fontSize: 18,
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
      this.listNotifications.replaceRange(
          this.notifyIdDelete, this.notifyIdDelete + 1, [this.notifyDelete]);
    });
  }

  void getNotifications(String userId) async {
    for (int i = 0; i < 50; i++) {
      int color = 0xFFFFFFFF;
      if (Random().nextInt(100) % 2 == 0) {
        color = 0xFFE3F2FD;
      }
      listNotifications.add(
        OneNotify(
          avatarUrl: 'https://www.gstatic.com/webp/gallery/1.jpg',
          messNotify:
              'this is a notification very very bla bla bla long long long chung ta kadas skdjs',
          timeNotify: 'yesterday 11:11:11',
          color: color,
          callback: deleteNotify,
          notifyId: i,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    getNotifications('placeholder');
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Notification',
          style: TextStyle(
            fontFamily: 'Candice',
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [for (var item in listNotifications) item],
        ),
      ),
    );
  }
}
