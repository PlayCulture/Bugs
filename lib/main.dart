import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool firstScannerActive = true;
  bool secondScannerActive = false;

  void toggleSecondScanner() async {
    if (secondScannerActive) {
      setState(() {firstScannerActive = false; secondScannerActive = false;});
      await Future.delayed(Duration(milliseconds: 250));
      setState(() {firstScannerActive = true;});
    } else if (!secondScannerActive) {
      setState(() {secondScannerActive = true;});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: 
    
    AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title),), body: 
      Center(child: 
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            
          const Text('Tap the button to toggle loading the second instance of MobileScanner', textAlign: TextAlign.center),

          firstScannerActive ?
          SizedBox(width: 200.0, height: 200.0, child:
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
            onDetectError: (context, error) {
              print("Error: "+error.toString());
            },
          ),
          ) : const SizedBox(height: 0.0) ,

          secondScannerActive ?
          SizedBox(width: 200.0, height: 200.0, child:
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
            onDetectError: (context, error) {
              print("Error: "+error.toString());
            },
          ),
          ) : const SizedBox(height: 0.0) ,
            
        ],),
      ),
      floatingActionButton: 
      FloatingActionButton(onPressed: toggleSecondScanner, tooltip: 'Toggle Second Scanner', child: 
        const Icon(Icons.refresh),
      ),
    );
  }
}
