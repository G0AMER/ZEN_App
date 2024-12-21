import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String _scanResult = "No data scanned yet.";

  Future<void> scanBarcode() async {
    try {
      var scanResult = await BarcodeScanner.scan();
      setState(() {
        _scanResult = scanResult.rawContent.isEmpty
            ? "No barcode detected."
            : scanResult.rawContent;
      });
    } catch (e) {
      setState(() {
        _scanResult = "Error scanning barcode: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scanned Data:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _scanResult,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Scan Barcode'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BarcodeScannerPage(),
  ));
}
