import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/api/Api.dart';
import 'package:socialapp/components/home/elements/Post.dart';
import 'package:socialapp/components/login/Login.dart';
import 'package:socialapp/qrCode/qrcode.dart';
import 'package:socialapp/reuseComponents/ClipIconButton.dart';
import 'package:socialapp/reuseComponents/SnackBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showDialog(Text customTitle, Text customMessage,
      {List<Widget> listActionButton}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: customTitle,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                if (customMessage != null) customMessage,
              ],
            ),
          ),
          actions: listActionButton,
        );
      },
    );
  }

  SliverAppBar topAppbar() {
    return SliverAppBar(
      // brightness: Brightness.light,
      // titleSpacing: 20,
      elevation: 3.0,
      centerTitle: true,
      leading: QRcodeOptions(),
      title: Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 14),
            ),
          ),
          child: Text(
            "COMNET",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Candice',
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      floating: true,
      pinned: false,
      snap: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 23.0, top: 5.0),
          child: Container(
            child: singleClipOvalButton(
              icon: FontAwesomeIcons.signOutAlt,
              sizeButton: 27.0,
              iconColor: Colors.black,
              splashColor: Colors.white,
              iconSize: 24.0,
              callbackFunction: () {
                _showDialog(
                  Text(
                    'Do you want to sign out?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                  null,
                  listActionButton: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        try {
                          API().logout().then((res) {
                            if (res.statusCode == 201) {
                              print(res.body);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(
                                snackBar(
                                  'No internet or server not response!!!')
                              );
                            }
                          });
                        } on Exception {
                          Scaffold.of(context).showSnackBar(
                            snackBar(
                              'No internet or server not response!!!'
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool value) {
          return [
            topAppbar(),
          ];
        },
        body: ListView(
          children: [
            NewPost(avatarUrl: 'https://www.gstatic.com/webp/gallery/2.jpg'),
            Divider(
              color: Colors.grey[350],
              thickness: 1,
              indent: 13,
              endIndent: 13,
            ),
            for (var i = 0; i < 10; i++)
              CardPost(
                postId: 'asjhdkasjdh',
              )
          ],
        ),
      ),
    );
  }
}
