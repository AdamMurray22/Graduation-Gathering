import 'package:flutter/material.dart';
import 'package:questionnaire_web_app/screens_enum.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.changeScreen});

  final Function(int screenIndex) changeScreen;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
    children: [
    ElevatedButton(onPressed: () {_changeScreen(ScreensEnum.termsScreen);}, child: Text("Button back Hi"),),
    ]));
  }

  _changeScreen(ScreensEnum screen)
  {
    widget.changeScreen(screen.screenIndex);
  }
}