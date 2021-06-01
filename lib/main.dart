import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:least_sum/db/firebase_database.dart';
import 'package:least_sum/screens/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Least Sum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartGame(),
    );
  }
}
