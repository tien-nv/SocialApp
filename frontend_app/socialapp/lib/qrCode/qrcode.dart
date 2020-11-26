import 'package:socialapp/popup/sheetBottom/bottomSheet.dart';
import 'package:socialapp/reuseComponents/ClipIconButton.dart';
import 'package:socialapp/routeClass/ScaleAnimation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeOptions extends StatefulWidget {
  @override
  _QRcodeOptionsState createState() => _QRcodeOptionsState();
}

class _QRcodeOptionsState extends State<QRcodeOptions> {
  String userId = 'bal bla baskdjalkds';
  String resultOfQrCode = "";

  _scan() async {
    ///mau` cua ma qrcode
    ///ten cua? nut' cancel
    ///co' su? dung den` hay khong
    ///quet' ma qr hay bar code
    ///qrcode or barcode
    return await FlutterBarcodeScanner.scanBarcode(
            '#ff000000', 'Hủy', true, ScanMode.QR)
        .then((value) {
      setState(() {
        resultOfQrCode = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, top: 5.0),
      child: Center(
        child: singleClipOvalButton(
          icon: Icons.qr_code_scanner,
          splashColor: Colors.grey[700],
          iconSize: 28,
          iconColor: Colors.black,
          sizeButton: 35,
          backgroundColor: Colors.white,
          callbackFunction: () {
            showSlideBottomSheet(
              context,
              listOptions: [
                singleOption(
                  'Quét mã QR',
                  context: context,
                  iconOption: Icons.qr_code_scanner,
                  callbackFunction: () async {
                    Navigator.pop(context);
                    await _scan();
                    //placeholder
                    print('result of qr code $resultOfQrCode');
                  },
                ),
                singleOption(
                  'Hiển thị mã QR của riêng bạn',
                  context: context,
                  iconOption: FontAwesomeIcons.qrcode,
                  callbackFunction: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      ScaleAnimationRoute(
                        page: GenerateQrCode(
                          userId: this.userId,
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class GenerateQrCode extends StatelessWidget {
  final String userId;

  const GenerateQrCode({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: (userId == "" || userId == null)
              ? Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      'Có gì đó sai sai, bạn hãy kiểm tra kết nối rồi thử lại sau.\nChúng tôi xin lỗi vì sự bất tiện này.'),
                )
              : Container(
                  child: QrImage(data: userId),
                ),
        ),
      ),
    );
  }
}
