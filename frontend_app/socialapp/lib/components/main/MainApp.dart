import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/components/chat/ChatHome.dart';
import 'package:socialapp/components/home/Home.dart';
import 'package:socialapp/components/notify/Notify.dart';
import 'package:socialapp/components/profile/Profile.dart';

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

class MainApp extends StatefulWidget {
  final String accessToken;
  MainApp({this.accessToken});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  bool showMoreButton = false;
  List listOptionButton;
  List<Function> listAction;
  List alignX = [];
  List alignY = [];

  int timeDuration = 450;

  TabController tabController;
  AnimationController _animationController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: timeDuration),
    );
    listOptionButton = [Icons.add, Icons.add, Icons.add, Icons.add, Icons.add];
    listAction = [
      () {},
      () {},
      () {},
      () {},
      () {},
    ];
    int len = listOptionButton.length - 1;
    for (int i = 0; i < listOptionButton.length; i++) {
      alignX.add(-(2 * cos(pi / (2 * len) * i) - 1));
      alignY.add(1 - 2 * sin(pi / (2 * len) * i));
    }
    tabController.addListener(() {
      setState(() {
        selectedTab = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> buildPageView() {
    return [
      KeepAlivePage(
        child: HomePage(),
      ),
      KeepAlivePage(
        child: ChatPage(),
      ),
      KeepAlivePage(
        child: UserNotifications(userId: 'placeholer'),
      ),
      KeepAlivePage(
        child: UserProfile(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: TabBarView(
        controller: tabController,
        children: buildPageView(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: timeDuration),
        height: showMoreButton ? size.width * 0.5 : 50,
        width: showMoreButton ? size.width * 0.5 : 50,
        child: Stack(
          children: [
            for (int index = 0; index < listOptionButton.length; index++)
              singleAlignButton(
                  Duration(milliseconds: (timeDuration / (index + 1)).round()),
                  Curves.linear,
                  Alignment(alignX[index], alignY[index]),
                  listOptionButton[index],
                  iconColor: selectedTab == 1 ? Colors.black : Colors.white,
                  callbackFunction: listAction[index]),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showMoreButton = !showMoreButton;
                    });
                    showMoreButton
                        ? _animationController.forward()
                        : _animationController.reverse();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      color:
                          (selectedTab == 1) ? Colors.white : Colors.grey[700],
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _animationController,
                          color:
                              (selectedTab == 1) ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: (selectedTab == 1) ? Colors.black : Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 10.0,
        child: TabBar(
          controller: tabController,
          tabs: [
            Tab(icon: Icon(FontAwesomeIcons.home)),
            Tab(icon: Icon(FontAwesomeIcons.facebookMessenger)),
            Tab(icon: Icon(FontAwesomeIcons.bell)),
            Tab(icon: Icon(FontAwesomeIcons.userCircle)),
          ],
          labelColor: Colors.amber[800],
          unselectedLabelColor:
              (selectedTab == 1) ? Colors.white : Colors.grey[700],
          // indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5),
          indicatorColor: Colors.transparent,
        ),
      ),
    );
  }

  AnimatedAlign singleAlignButton(Duration _duration, Curve _curve,
      AlignmentGeometry _alignment2, IconData icon,
      {callbackFunction, iconColor = Colors.white}) {
    return AnimatedAlign(
      duration: _duration,
      curve: _curve,
      alignment: showMoreButton ? _alignment2 : Alignment(1.0, 1.0),
      child: Container(
        height: 40,
        width: 40,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 35,
                height: 35,
                child: GestureDetector(
                  onTap: callbackFunction,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      color:
                          (selectedTab == 1) ? Colors.white : Colors.grey[700],
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          icon,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
