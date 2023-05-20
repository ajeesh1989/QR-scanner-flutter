import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyCustomWidget(),
    );
  }
}

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  var getResultQr = '';
  // var getResultBar = 'Bar code Result';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'QR Scanner',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Click on the 'Scan QR code' button",
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
                    'Scanning will be start qutomatically',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  )
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                scanQRCode();
              },
              child: const Text('Scan QR code'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Text(
            //   getResultQr,
            //   style: TextStyle(),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextButton(
                onPressed: () async {
                  launchUr(Uri.parse(getResultQr));
                },
                child: Text(
                  getResultQr,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                    text: 'Developer name   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'aj_labs',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResultQr = qrCode;
      });
    } on PlatformException {
      getResultQr = 'Failed to scan QR Code.';
    }
  }

  Future<void> launchUr(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch ';
    }
  }
}
