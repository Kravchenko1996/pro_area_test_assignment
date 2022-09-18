import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'model/fact/fact_rest_client.dart';
import 'view/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FactAdapter());

  Intl.defaultLocale = 'en_GB';
  initializeDateFormatting('en_GB');
  initializeDateFormatting('uk_UA');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'GB'),
        Locale('uk', 'UA'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Cat Trivia',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Hive.openBox<Fact>('facts'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(backgroundColor: Colors.blueGrey);
          }
          return const HomePage();
        },
      ),
    );
  }
}
