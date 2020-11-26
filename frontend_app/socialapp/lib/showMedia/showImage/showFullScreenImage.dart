import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowFullListImage extends StatelessWidget {
  List<String> listLinkImage = [];

  ShowFullListImage({Key key, this.listLinkImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
      ),
      backgroundColor: Color(0xFF000000),
      extendBodyBehindAppBar: true,
      body: PageView(
        children: [
          for (var item in listLinkImage)
            Container(
              child: (item != '')
                  ? Image.network(
                      item,
                      fit: BoxFit.contain,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    )
                  : Center(
                      child: Text('Đã xảy ra lỗi gì đó :(('),
                    ),
            ),
        ],
      ),
    );
  }
}
