import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:qrdemo/main.dart';
import 'package:url_launcher/url_launcher.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});
  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    await controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          buildQrView(context),
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (() async {
                          await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              ModalRoute.withName('/Home'));
                        }),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.63),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: buildResult(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                  onTap: _launchURL,
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'Open in App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildResult() => Text(
        barcode != null ? '${barcode!.code}' : 'Scan a code!',
        maxLines: 3,
        style: TextStyle(
          color: Colors.blue[300],
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 8,
          borderRadius: 15,
          borderColor: Colors.blue,
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) => setState((() {
          this.barcode = barcode;
          launcherUrl();
          // controller.dispose();
        })));
    setState(
      () {
        controller.resumeCamera();
      },
    );
    // if (barcode != null) {
    //   try {
    //     launcherUrl();
    //   } catch (e) {
    //     print('****************');
    //     print(e);
    //   }
    // }
  }

  // void launchURL() async {
  //   try {
  //     await canLaunchUrl(Uri.parse('${barcode!.code}'))
  //         ? await launchUrl(Uri.parse('${barcode!.code}'))
  //         : throw 'Could not launch ${barcode!.code}';
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  _launchURL() async {
    var url = '${barcode!.code}';
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launcherUrl() async {
    var url = '${barcode!.code}';
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
