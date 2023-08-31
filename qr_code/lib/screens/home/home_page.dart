import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/qr_code/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const QRSCanner())
          );
        },
        child: const Icon(Icons.qr_code_scanner_rounded,
        color: Colors.lightBlue,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Scanned Codes'),
          elevation: 2,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.arrow_back_ios)
            ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('qrCodesCollection').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }
                final qrCodes = snapshot.data!.docs;
                if(qrCodes.isEmpty){
                  return const Center(
                    child: Text(
                      'No products scanned yet. Scan to get the codes here.',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: qrCodes.length,
                  itemBuilder: (context, index) {
                    final qrCode = qrCodes[index];
                    final name = qrCode['name'];
                    final code = qrCode['barCodeResults'];
                    final email = qrCode['email'];
                    return ListTile(
                      title: Text(
                        '$name',
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$code'),
                          Text('$email')
                        ],
                      ),
                    );
                  }
                  );
              },
            ),
            ),
        ),
    );
  }
}