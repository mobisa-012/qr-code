import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_qrcode_scanner/dynamsoft_barcode.dart';
import 'package:flutter_camera_qrcode_scanner/flutter_camera_qrcode_scanner.dart';
import 'package:qr_code/core/data/qrcode_data.dart';

class QRSCanner extends StatefulWidget {
  const QRSCanner({super.key});

  @override
  State<QRSCanner> createState() => _QRSCannerState();
}

class _QRSCannerState extends State<QRSCanner> {
  ScannerViewController? scannerViewController;
  String barCodeResults ='';
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scannerViewController?.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product code'),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          ScannerView(
            onScannerViewCreated: onScannerViewCreated,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Enter product name'
                    ),
                    validator: (value) {
                      if(value == null) {
                        return 'please enter product name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Text(
                      barCodeResults,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.lightBlue
                      ),
                    ),
                  ),                  
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async{                            
                      scannerViewController!.startScanning();
                    }, 
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width,45),
                      backgroundColor: Colors.lightBlue
                    ),
                    child: const Text('Start scan'),                          
                    ),
                )
              ],
            )          
        ],
      ),
    );
  }
 void onScannerViewCreated(ScannerViewController controller) async {
    setState(() {
      scannerViewController = controller;
    });
    await controller.setLicense(
        'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    await controller.init();
    await controller.startScanning(); // auto start scanning
    controller.scannedDataStream.listen((results) {
      setState(() {
        barCodeResults = getBarcodeResults(results);
      });
      if(results.isNotEmpty) {
        saveQRCodeData();
      }
    });
  }

  Future<void> saveQRCodeData() async {
    final email = FirebaseAuth.instance.currentUser!.email;
        final qrCodeData = QRCodeData(
          barCodeResults: barCodeResults, 
          email: email!, 
          name: nameController.text,
          );
          await FirebaseFirestore.instance.collection('qrCodesCollection')
          .add(qrCodeData.toJson());
  }

 String getBarcodeResults(List<BarcodeResult> results) {
    StringBuffer sb = StringBuffer();
    for (BarcodeResult result in results) {
      sb.write(result.format);
      sb.write("\n");
      sb.write(result.text);
      sb.write("\n\n");
    }
    if (results.isEmpty) sb.write("No QR Code Detected");
    return sb.toString();
  }

}