import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/popup/sheetBottom/bottomSheet.dart';
import 'package:socialapp/reuseComponents/ClipIconButton.dart';

// ignore: must_be_immutable
class OneNotify extends StatefulWidget {
  final String avatarUrl;
  final String messNotify;
  final String timeNotify;
  final int color;
  final int notifyId;
  Function callback;

  OneNotify({
    Key key,
    @required this.avatarUrl,
    @required this.messNotify,
    this.timeNotify,
    this.color,
    this.notifyId,
    this.callback,
  }) : super(key: key);
  @override
  _OneNotifyState createState() => _OneNotifyState();
}

class _OneNotifyState extends State<OneNotify> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String notifyContent = widget.messNotify;
    String notifyTime = widget.timeNotify;

    return Card(
      borderOnForeground: false,
      elevation: 0.0,
      color: Color(widget.color),
      margin: EdgeInsets.all(0),
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 8.0,bottom: 8.0),
        leading: Container(
          padding: EdgeInsets.only(left: 13.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 22.5,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.avatarUrl),
            ),
          ),
        ),
        title: Text(
          '$notifyContent',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          child: Text(
            '$notifyTime',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
        onTap: () {},
        onLongPress: () {
          showSlideBottomSheet(context, listOptions: [
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF9E9E9E),
                        radius: 23,
                        backgroundImage: NetworkImage(widget.avatarUrl),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 11.0, left: 19, right: 19),
                    child: Text(
                      widget.messNotify,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF757575),
                          fontFamily: 'Proxima'),
                    ),
                  ),
                ],
              ),
            ),
            singleOption(
              'Gỡ thông báo này',
              iconOption: FontAwesomeIcons.timesCircle,
              callbackFunction: () {
                Navigator.pop(context);
                widget.callback(widget.notifyId);
              },
            ),
          ]);
        },
      ),
    );
  }
}
