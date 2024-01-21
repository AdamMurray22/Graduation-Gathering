import 'package:flutter/material.dart';
import 'package:questionnaire_web_app/AWS/send_answers.dart';
import 'package:questionnaire_web_app/screens_enum.dart';
import 'package:questionnaire_web_app/survey_answers.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.changeScreen});

  final Function(int screenIndex) changeScreen;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Text _q1 = const Text("Q1. Please select the following that applies to you:");

  final List<bool> _q1CheckBoxes = [false, false, false];

  final List<String> _q2ReorderableList = [
    "Users of the app are verified as University of Portsmouth staff or graduates",
    "That you can be selective about which graduation zones you can be seen in by others",
    "That you can be selective about which graduation zones you can see other in",
    "You can filter which users you see by course",
    "You can filter which users you see by name",
    "You can filter which users you see by whether you've already met",
    "A messaging service to allow you to communicate with others",
  ];

  final List<String> _q3ReorderableList = [
    "Guildhall square",
    "Ravelin park",
    "The area between Guildhall and Ravelin park",
    "Pryzm"
  ];

  String _q4Text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      ElevatedButton(
        onPressed: () {
          _changeScreen(ScreensEnum.termsScreen);
        },
        child: const Text("Back To Participant Information Sheet"),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      _q1,
      Row(
        children: [
          const Text("Student"),
          Checkbox(
              value: _q1CheckBoxes[0],
              onChanged: (checked) {
                _checkBoxTicked(0, checked!);
              })
        ],
      ),
      Row(
        children: [
          const Text("Staff"),
          Checkbox(
              value: _q1CheckBoxes[1],
              onChanged: (checked) {
                _checkBoxTicked(1, checked!);
              })
        ],
      ),
      Row(
        children: [
          const Text("Prefer Not to Say"),
          Checkbox(
              value: _q1CheckBoxes[2],
              onChanged: (checked) {
                _checkBoxTicked(2, checked!);
              })
        ],
      ),
      const Text(
          "Q2. Please arrange the following list of features from most important to you at the top, to least important to you at the bottom:"),
      ReorderableListView(
          scrollController: ScrollController(),
          shrinkWrap: true,
          onReorder: (oldIndex, newIndex) {
            _onReorder(_q2ReorderableList, oldIndex, newIndex);
          },
          children: _q2ReorderableList
              .map((item) => Text(item, key: Key(item)))
              .toList()),
      const Text(
          "A Graduation zone in this context means an area of portsmouth that can be designated on the app to show peoples locations."),
      const Text(
          "Q3. Please arrange the following list of graduation zones from most important to you at the top, to least important to you at the bottom:"),
      ReorderableListView(
          scrollController: ScrollController(),
          shrinkWrap: true,
          onReorder: (oldIndex, newIndex) {
            _onReorder(_q3ReorderableList, oldIndex, newIndex);
          },
          children: _q3ReorderableList
              .map((item) => Text(item, key: Key(item)))
              .toList()),
      const Text(
          "Q4(Optional). Please enter any other parts of Portsmouth you would like to be designated as graduation zones:"),
      TextField(
        onChanged: (text) {
          _q4Text = text;
        },
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
          ),
          hintText: 'Enter text here...',
        ),
      ),
        ],),
      
      ElevatedButton(
        onPressed: () {
          bool submitted = _submitResults();
          if (submitted) {
            _changeScreen(ScreensEnum.thankYouScreen);
          } else {
            setState(() {
              _q1 = Text(_q1.data!, style: const TextStyle(color: Colors.red));
            });
          }
        },
        child: const Text("Submit"),
      ),
    ])));
  }

  _changeScreen(ScreensEnum screen) {
    widget.changeScreen(screen.screenIndex);
  }

  _checkBoxTicked(int box, bool checked) {
    setState(() {
      for (int i = 0; i < _q1CheckBoxes.length; i++) {
        _q1CheckBoxes[i] = false;
      }
      _q1CheckBoxes[box] = checked;
    });
  }

  _onReorder(List<String> reorderableList, int start, int current) {
    // dragging from top to bottom
    if (start < current) {
      int end = current - 1;
      String startItem = reorderableList[start];
      int i = 0;
      int local = start;
      do {
        reorderableList[local] = reorderableList[++local];
        i++;
      } while (i < end - start);
      reorderableList[end] = startItem;
    }
    // dragging from bottom to top
    else if (start > current) {
      String startItem = reorderableList[start];
      for (int i = start; i > current; i--) {
        reorderableList[i] = reorderableList[i - 1];
      }
      reorderableList[current] = startItem;
    }
    setState(() {});
  }

  bool _submitResults() {
    SurveyAnswers answers = SurveyAnswers(
        _q1CheckBoxes, _q2ReorderableList, _q3ReorderableList, _q4Text);
    if (!answers.answersValid()) {
      return false;
    }
    SendAnswers sendAnswers = SendAnswers();
    sendAnswers.send(answers);
    return true;
  }
}
