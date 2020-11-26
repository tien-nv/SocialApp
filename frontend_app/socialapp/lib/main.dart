import 'package:flutter/material.dart';
import 'package:socialapp/components/login/Login.dart';
import 'package:socialapp/components/main/MainApp.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle( //change status bar color to none
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Social Network",
      home: isLogin ? MainApp() : Login(),
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
