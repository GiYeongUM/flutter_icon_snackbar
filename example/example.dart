import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IconDialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon SnackBar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  IconSnackBar.show(
                    context,
                    snackBarType: SnackBarType.fail,
                    maxLines: 1,
                    label: 'Data required',
                  );
                },
                child: const Text("test"))
          ],
        ),
      ),
    );
  }
}
