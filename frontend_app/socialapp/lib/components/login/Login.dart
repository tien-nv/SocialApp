import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/api/Api.dart';
import 'package:socialapp/components/main/MainApp.dart';
import 'package:socialapp/reuseComponents/ClipIconButton.dart';
import 'package:socialapp/reuseComponents/SnackBar.dart';
import 'package:socialapp/routeClass/SlideAnimation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  bool isLogining = false;
  bool isShowPass = false;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  var _colorTween;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //for api
  final storage = new FlutterSecureStorage();

  setStringData(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value.toString());
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _colorTween = _animationController
        .drive(ColorTween(begin: Colors.red, end: Colors.green));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Form formLogin(Size size) {
    return Form(
      key: _formKey,
      child: Wrap(
        runSpacing: 25.0,
        children: <Widget>[
          Center(
            child: Container(
              width: size.width * 0.7,
              child: TextFormField(
                controller: emailTextController,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                showCursor: true,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.only(top: 15.0, bottom: 3.0),
                  suffix: singleClipOvalButton(
                    backgroundColor: Colors.grey[400],
                    icon: Icons.close,
                    iconSize: 13,
                    sizeButton: 18,
                    callbackFunction: () {
                      emailTextController.clear();
                    },
                    iconColor: Colors.black,
                  ),
                  labelStyle: TextStyle(
                      fontSize: 14,
                      backgroundColor: Colors.white,
                      color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber[800])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  // prefix: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This is not allow null';
                  }
                  return null;
                },
              ),
            ),
          ),
          Center(
            child: Container(
              width: size.width * 0.7,
              child: TextFormField(
                enableSuggestions: false,
                controller: passwordTextController,
                autocorrect: false,
                obscureText: !isShowPass,
                showCursor: true,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.only(top: 15.0, bottom: 3.0),
                  suffix: singleClipOvalButton(
                    backgroundColor: Colors.white,
                    icon: (isShowPass)
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    iconSize: 17,
                    sizeButton: 20,
                    callbackFunction: () {
                      setState(() {
                        isShowPass = !isShowPass;
                      });
                    },
                    iconColor: Colors.black,
                  ),
                  labelStyle: TextStyle(
                      backgroundColor: Colors.white, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber[800])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    // return 'This is not allow null';
                    return null;
                  }
                  return null;
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: RaisedButton(
                elevation: 0.0,
                focusElevation: 0.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  side: BorderSide(
                    color: Colors.amber[900],
                  ),
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    // Scaffold.of(context)
                    //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                    setState(() {
                      isLogining = true;
                    });
                    String email = emailTextController.text;
                    String password = passwordTextController.text;
                    try {
                      API().login(email, password).then((response) {
                        if (response.statusCode != 201) {
                          isLogining = false;
                          Scaffold.of(context).showSnackBar(
                            snackBar(
                              'No internet or server not response')
                          );
                          print(response);
                        } else {
                          var data = json.decode(response.body);
                          print(data);
                          if (data["status"]) {
                            storage.write(key: "token", value: data["token"]);
                            Map<String, dynamic> user = data['user'];
                            for (var element in user.entries) {
                              setStringData(element.key, element.value);
                            }
                            isLogining = false;
                            Navigator.pushReplacement(
                              context,
                              EnterExitRoute(
                                prevPage: this.widget,
                                nextPage: MainApp(),
                              ),
                            );
                          } else {
                            isLogining = false;
                            Scaffold.of(context).showSnackBar(
                              snackBar(
                                'Email or password is not true!!!'
                              ),
                            );
                          }
                        }
                      });
                    } on Exception {
                      isLogining = false;
                      Scaffold.of(context).showSnackBar(
                        snackBar(
                          'No internet or server not response'
                        ),
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: RaisedButton(
                elevation: 0.0,
                focusElevation: 0.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  side: BorderSide(
                    color: Colors.amber[900],
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isLogining = true;
                  });
                  Timer(Duration(seconds: 15), () {
                    Navigator.push(
                      context,
                      EnterExitRoute(
                        prevPage: this.widget,
                        nextPage: MainApp(),
                      ),
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Text(
                    'TEST TO MAIN SCREEN',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Container(
            child: Wrap(
              runSpacing: 50.0,
              children: [
                AnimatedContainer(
                  height: isLogining ? size.height * 0.53 : size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'COMNET',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontFamily: 'Candice',
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  onEnd: () {},
                ),
                if (!isLogining)
                  Container(
                    width: double.infinity,
                    child: formLogin(size),
                  )
                else
                  Container(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: _colorTween,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
