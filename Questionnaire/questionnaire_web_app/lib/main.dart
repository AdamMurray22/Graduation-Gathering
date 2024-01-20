import 'package:flutter/material.dart';
import 'package:questionnaire_web_app/questions_screen.dart';
import 'package:questionnaire_web_app/terms_screen.dart';
import 'package:questionnaire_web_app/thank_you_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int screenStackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: screenStackIndex, children: [
        TermsScreen(changeScreen: _changeScreen),
        QuestionsScreen(changeScreen: _changeScreen),
        const ThankYouScreen()
      ]),
    );
  }

  _changeScreen(int screenIndex) {
    setState(() {
      screenStackIndex = screenIndex;
    });
  }
}
