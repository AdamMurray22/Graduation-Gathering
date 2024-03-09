import 'package:flutter/material.dart';
import 'package:graduation_gathering/Screen/screen_holder.dart';

import 'Location/location_handler.dart';


/// Target for start of application.
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// The entire application is started from this class.
class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    LocationHandler.getHandler().requestLocationPermission();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: true,
        home: ScreenHolder(),
    );
  }
}