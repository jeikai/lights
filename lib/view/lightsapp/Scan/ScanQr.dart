import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/Scan/resultScreen.dart';
import 'package:flutterapp/view/lightsapp/cardMenu/Card.dart';
import 'package:flutterapp/view/lightsapp/cardMenu/CardMenu.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bgColor = Color(0xfffafafa);

class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  bool inScanCompleted = false;
  bool isFlashOn = false;
  MobileScannerController controller = MobileScannerController();
  void closeScreen() {
    inScanCompleted = false;
  }

  bool isCodeValid(String code) {
    final RegExp regex =
        RegExp(r'^https://lights-server-2r1w.onrender.com/api/scanCard/\d+$');
    return regex.hasMatch(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              ))
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 250, 241, 255),
        title: Text(
          'light s',
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.6,
            fontSize: 30.0,
            fontFamily: 'Mistrully',
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 195, 160, 212),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              child: Column(
                children: const [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning automatically",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            )),
            Expanded(
                flex: 4,
                child: Stack(children: [
                  MobileScanner(
                    controller: controller,
                    onDetect: (barcode) async {
                      if (!inScanCompleted) {
                        inScanCompleted = true;
                        String code = barcode.raw[0]['url']['url'] ?? '---';
                        if (isCodeValid(code)) {
                          Map data = {"userId": Preferences.getId()};
                          var response = await Api().scanQR(code, data);
                          print(response);
                          if (response?["message"] == "Success") {
                            ToastNoti.show("Quét QR thành công");
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/Card");
                          } else {
                            ToastNoti.show("Quét QR không thành công");
                          }
                        } else {
                          inScanCompleted = false;
                          ToastNoti.show("Mã QR không hợp lệ");
                        }
                      }
                    },
                  ),
                  QRScannerOverlay(overlayColor: bgColor),
                ])),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                "Light's",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
