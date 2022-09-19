// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class QrPage extends StatefulWidget {
//   const QrPage({super.key});

//   @override
//   State<QrPage> createState() => _QrPageState();
// }

// class _QrPageState extends State<QrPage> {
//   MobileScannerController cameraController = MobileScannerController();
//   bool screenOpened = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MobileScanner(
//         allowDuplicates: true,
//         controller: cameraController,
//         onDetect: _foundBarcode,
//       ),
//     );
//   }


//   void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
//     /// open screen
//     if (!_screenOpened) {
//       final String code = barcode.rawValue ?? "---";
//       debugPrint('Barcode found! $code');
//       _screenOpened = true;
//       Navigator.push(context, MaterialPageRoute(builder: (context) =>
//           FoundCodeScreen(screenClosed: _screenWasClosed, value: code),));
//     }
//   }

//   void _screenWasClosed() {
//     _screenOpened = false;
//   }
// }

