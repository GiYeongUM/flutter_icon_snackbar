import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Status snack bars',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    darkTheme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
    ),
    home: const ExamplePage(),
  );
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});
  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Status snack bars')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        for (final type in SnackBarType.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FilledButton(
              onPressed: () => showIconSnackBar(
                context,
                type: type,
                label: 'Status: ${type.name}',
              ),
              child: Text('Show ${type.name}'),
            ),
          ),
      ],
    ),
  );
}
