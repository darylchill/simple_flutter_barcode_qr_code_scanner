import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click the camera button to read qr codes:',
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getBarcodeValue(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> getBarcodeValue(BuildContext context1) async {
    final code = await Navigator.push(
      context1,
      MaterialPageRoute(builder: (context) =>  const BarcodeScannerWithController()),
    );
    if (kDebugMode) {
      print("Barcode: $code");
    }
    if(code!= null){
      if (!mounted) return;
      AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.warning,
        title: code.toString(),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: true,
      ).show();
    }
  }

}

