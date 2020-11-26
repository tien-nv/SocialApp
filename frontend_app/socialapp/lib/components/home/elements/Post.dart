import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/popup/sheetBottom/bottomSheet.dart';
import 'package:socialapp/reuseComponents/ClipIconButton.dart';
import 'package:socialapp/routeClass/ScaleAnimation.dart';
import 'package:socialapp/routeClass/SlideAnimation.dart';
import 'package:socialapp/showMedia/showImage/showFullScreenImage.dart';

class CardPost extends StatefulWidget {
  final String postId;

  const CardPost({Key key, this.postId}) : super(key: key);
  @override
  _CardPostState createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  //variance for header of post
  String avatarUrl;
  String userName;
  bool isOwner;

  //body of post
  String content;
  List<String> listMedia;
  int activeDot = 1;
  String dateTime;
  int mediaLen;
  bool showMediaNumber = false;

  //relation ship with post
  bool isLiked;

  @override
  void initState() {
    super.initState();
    //
    avatarUrl = 'https://www.gstatic.com/webp/gallery/4.jpg';
    userName = 'Nguyen Van Tien';
    isOwner = true;
    //
    content =
        'This is content of post is very long bla bla bla bla,.............';
    listMedia = [
      'https://www.gstatic.com/webp/gallery/4.jpg',
      'https://www.gstatic.com/webp/gallery/5.jpg',
      'https://www.gstatic.com/webp/gallery/4.jpg',
      'https://www.gstatic.com/webp/gallery/5.jpg',
    ];
    dateTime = 'November 09 2020';
    //
    listMedia = listMedia.sublist(0, Random().nextInt(listMedia.length));
    isLiked = false;
    mediaLen = listMedia.length;
  }

  Widget buildOneImage(String url) {
    return Image.network(
      url,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.0,
      margin: EdgeInsets.only(top: 9, bottom: 9),
      borderOnForeground: false,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 22.5,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
            title: Text(
              '$userName',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '$dateTime',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            trailing: singleClipOvalButton(
              backgroundColor: Colors.white,
              icon: FontAwesomeIcons.ellipsisV,
              iconColor: Colors.grey[700],
              splashColor: Colors.grey[350],
              callbackFunction: () {
                //placeholder
              },
            ),
          ),
          if (content != '')
            Container(
               padding: const EdgeInsets.only(
                    top: 4.0, bottom: 7.0, left: 13.0, right: 13.0),
              child: Text(
                '$content',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          if (listMedia.length > 0)
            GestureDetector(
              onDoubleTap: () {
                likePost();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  height: size.width,
                  width: size.width,
                  color: Colors.grey[400],
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        height: size.width,
                        width: size.width,
                        color: Colors.grey[400],
                        child: PageView(
                          children: [
                            for (var url in listMedia) buildOneImage(url)
                          ],
                          onPageChanged: (index) {
                            setState(() {
                              activeDot = index + 1;
                              showMediaNumber = true;
                            });
                            Timer(Duration(seconds: 4), () {
                              setState(() {
                                showMediaNumber = false;
                              });
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: singleClipOvalButton(
                            backgroundColor: Colors.black.withOpacity(0.7),
                            iconSize: 23,
                            sizeButton: 40,
                            iconColor: Colors.white,
                            icon: FontAwesomeIcons.expandArrowsAlt,
                            callbackFunction: () {
                              Navigator.push(
                                context,
                                ScaleAnimationRoute(
                                  page: ShowFullListImage(
                                    listLinkImage: this.listMedia,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          color: Colors.transparent,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: (mediaLen > 1)
                                ? ((showMediaNumber) ? 1 : 0)
                                : 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[900].withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                left: 17.0,
                                right: 17.0,
                              ),
                              child: (mediaLen > 1)
                                  ? Text(
                                      '$activeDot/$mediaLen',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      '1/1',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 13.0, bottom: 13.0, left: 13.0, right: 2.0),
                child: singleClipOvalButton(
                  icon: (isLiked) ? Icons.favorite : Icons.favorite_border,
                  iconSize: 30.0,
                  iconColor: (isLiked) ? Colors.red : Colors.black,
                  sizeButton: 39.0,
                  callbackFunction: () {
                    likePost();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 13.0, bottom: 13.0, left: 2.0, right: 2.0),
                child: singleClipOvalButton(
                  icon: FontAwesomeIcons.comment,
                  iconSize: 25.0,
                  iconColor: Colors.black,
                  sizeButton: 39.0,
                  callbackFunction: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 13.0, bottom: 13.0, left: 2.0, right: 7.0),
                child: singleClipOvalButton(
                  icon: FontAwesomeIcons.paperPlane,
                  iconSize: 25.0,
                  iconColor: Colors.black,
                  sizeButton: 39.0,
                  callbackFunction: () {},
                ),
              ),
              if (listMedia.length > 1)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= listMedia.length; i++)
                        AnimatedContainer(
                          decoration: BoxDecoration(
                            color: (activeDot == i)
                                ? Colors.red
                                : Colors.grey[700],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(left: 2, right: 2),
                          padding: EdgeInsets.all(10),
                          duration: Duration(milliseconds: 300),
                          width: 10,
                          height: 10,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NewPost extends StatelessWidget {
  String avatarUrl;
  NewPost({key, this.avatarUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, bottom: 10.0, right: 7.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                // width: 100, // tru` di phan` padding
                // height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFFFFFF),
                    width: 5.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(60),
                  ),
                  color: Color(0xFFE9E9E9),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePost(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[400],
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[400],
                      radius: 29,
                      backgroundImage: NetworkImage(avatarUrl),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 14,
                          width: 14,
                          child: FloatingActionButton(
                            heroTag: null,
                            elevation: 0.4,
                            // backgroundColor: Colors.blue,
                            foregroundColor: Color(0xFF000000),
                            mini: true,
                            onPressed: () {
                              Navigator.push(
                                context,
                                SlideBottomToTopRoute(
                                  page: CreatePost(),
                                ),
                              );
                            },
                            child: Icon(
                              FontAwesomeIcons.plus,
                              size: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Post',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  //for media
  List listPathImage;
  final picker = ImagePicker();
  //for user
  String avatarUrl;
  String userName;

  //for state input
  TextEditingController _inputController;
  bool isReadOnly = false;
  bool hasContent = false;

  @override
  void initState() {
    super.initState();
    _inputController = new TextEditingController();
    _inputController.addListener(() {
      this.valueInput();
    });
    avatarUrl = 'https://www.gstatic.com/webp/gallery/4.jpg';
    userName = 'Nguyen Van Tien';
    listPathImage = [];
  }

  @override
  void dispose() {
    _inputController.dispose();
    listPathImage = [];
    super.dispose();
  }

  //for widget
  Container showOneImageFromDevice(var path) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      padding: EdgeInsets.all(8.0),
      height: 110,
      width: 110,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
              width: 110,
              height: 110,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 18,
              width: 18,
              child: FloatingActionButton(
                backgroundColor: Colors.black.withOpacity(0.7),
                elevation: 0.0,
                hoverElevation: 0.0,
                heroTag: path,
                onPressed: () {
                  setState(() {
                    listPathImage.remove(path);
                  });
                },
                mini: true,
                child: Icon(
                  Icons.close,
                  size: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

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
                customMessage,
              ],
            ),
          ),
          actions: listActionButton,
        );
      },
    );
  }

  //for media
  Future getImage({ImageSource source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);
    setState(
      () {
        if (pickedFile != null) {
          var path = pickedFile.path;
          // image = File(pickedFile.path);
          if (listPathImage.length < 7) {
            listPathImage.add(path);
            // var contain = listPathImage.where((element) => element == path);
            // if (contain.isEmpty)
            //   listPathImage.add(path);
            // else
            //   _showDialog(
            //     Text(
            //       'Alert',
            //       style: TextStyle(color: Colors.red),
            //     ),
            //     Text('You have choosen this before!!!'),
            //     listActionButton: <Widget>[
            //       TextButton(
            //         child: Text('Ok'),
            //         onPressed: () {
            //           Navigator.of(context).pop();
            //         },
            //       ),
            //     ],
            //   );
          } else {
            _showDialog(
              Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
              Text('Max of media post is 7'),
              listActionButton: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        } else {
          print('No image selected.');
        }
      },
    );
  }

  //for logic

  int findPositionSpace(String string) {
    int length = string.length;
    for (int i = length - 1; i >= 0; i--) {
      if (string[i] == " ") return i;
    }
    return -1;
  }

  void valueInput() {
    if (_inputController.text != null && _inputController.text.trim() != "") {
      setState(() {
        hasContent = true;
      });
    } else {
      setState(() {
        hasContent = false;
      });
    }
    var temp = _inputController.text;
    var tempClean = temp.trim();
    int position = findPositionSpace(tempClean);
    if (position != -1) {
      String firstString = temp.substring(0, position + 1);
      String twoString = temp.substring(position + 1, temp.length);
      if (twoString == ":D") {
        _inputController.text = firstString + "\u{1F600}";
        _inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: _inputController.text.length),
        );
      }
    } else {
      if (temp.trim() == ":D") {
        _inputController.text = "\u{1F600}";
        _inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: _inputController.text.length),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Create post",
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        actions: [
          FlatButton(
            child: Text(
              "Post",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: this.hasContent
                ? () {
                    //placeholder
                  }
                : null,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Content :',
                        style: TextStyle(
                          color: Colors.amber[800],
                          fontFamily: 'Candice',
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: TextField(
                      readOnly: this.isReadOnly,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _inputController,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: "Write something!!!",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              if (listPathImage.length > 0)
                Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Image attach :',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[600],
                            fontFamily: 'Candice',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 7,
                        children: [
                          for (var path in listPathImage)
                            showOneImageFromDevice(path)
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white),
        child: GestureDetector(
          onTap: () {
            showSlideBottomSheet(
              context,
              listOptions: [
                singleOption(
                  'Select image from gallery',
                  iconOption: FontAwesomeIcons.image,
                  context: context,
                  callbackFunction: () {
                    //placeholder
                    Navigator.pop(context);
                    getImage(source: ImageSource.gallery);
                  },
                ),
                singleOption(
                  'Select image from camera',
                  iconOption: FontAwesomeIcons.camera,
                  context: context,
                  callbackFunction: () {
                    //placeholder
                    Navigator.pop(context);
                    getImage(source: ImageSource.camera);
                  },
                ),
                singleOption(
                  'Select file',
                  iconOption: Icons.attach_file,
                  context: context,
                  callbackFunction: () {
                    //placeholder
                    print('clicked');
                  },
                ),
              ],
            );
          },
          child: ListTile(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            //   side: BorderSide(color: Colors.red,width: 2),
            // ),
            // focusColor: Colors.yellow,
            title: Text(
              "+ Add to your post",
              style: TextStyle(color: Colors.green[800]),
            ),
            trailing: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.image,
                    size: 30,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
