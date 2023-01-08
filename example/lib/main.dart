import 'package:dojah_flutter/dojah_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dojah Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DojahFinancial _dojahFinancial = DojahFinancial(
    appId: '',
    publicKey: '',
    type: DojahType.custom,
    metadata: {
      "reference": "someRef",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: OutlinedButton.icon(
          onPressed: () => _dojahFinancial.open(
            context,
            onSuccess: (v) => print('Success: $v'),
            onError: (v) => print('Error: $v'),
            onClose: (v) => print('Close: $v'),
          ),
          icon: const Icon(Icons.verified),
          label: const Text('Complete verification'),
        ),
      ),
    );
  }
}
