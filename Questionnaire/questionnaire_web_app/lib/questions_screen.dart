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
  Text _q1 = const Text("Q1. Please select the following that applies to you:", style: TextStyle(fontSize: 17));

  final List<bool> _q1CheckBoxes = [false, false, false];

  final List<String> _q2ReorderableList = [
    "Users of the app are verified as University of Portsmouth staff or graduates",
    "You can be selective about which graduation zones you can be seen in by others",
    "You can be selective about which graduation zones you can see others in",
    "You can filter which users you see by course",
    "You can filter which users you see by name",
    "You can filter which users you see by whether you've already met",
    "A messaging service to allow you to communicate with others",
  ];

  final List<DropdownMenuItem<Text>> _q3DropDownItems = [
    const DropdownMenuItem(value: Text("I want this as a zone"), child: Text("I want this as a zone")),
    const DropdownMenuItem(value: Text("I don't care if this is a zone"), child: Text("I don't care if this is a zone")),
    const DropdownMenuItem(value: Text("I don't want this as a zone"), child: Text("I don't want this as a zone")),
  ];

  final List<Text> _q3ButtonsValues = [];

  final List<String> _q3List = [
    "Guildhall square",
    "Ravelin park",
    "The area between Guildhall and Ravelin park"
  ];

  final Map<String, String> _q3Answers = {};

  String _q4Text = "";

  String _q5Text = "";

  @override
  void initState() {
    for (int i = 0; i < _q3List.length; i++)
    {
      _q3Answers[_q3List[i]] =  "I want this as a zone";
      _q3ButtonsValues.add(_q3DropDownItems[0].value!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(children: [
                  const SizedBox(height: 7),
                  ElevatedButton(
                    onPressed: () {
                      _changeScreen(ScreensEnum.termsScreen);
                    },
                    child: const Text("Back To Participant Information Sheet", style: TextStyle(fontSize: 17)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 7),
                      _q1,
                      const SizedBox(height: 7),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(children: [
                            Row(
                              children: [
                                const Text("Student", style: TextStyle(fontSize: 17)),
                                Checkbox(
                                    value: _q1CheckBoxes[0],
                                    onChanged: (checked) {
                                      _checkBoxTicked(0, checked!);
                                    })
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Staff", style: TextStyle(fontSize: 17)),
                                Checkbox(
                                    value: _q1CheckBoxes[1],
                                    onChanged: (checked) {
                                      _checkBoxTicked(1, checked!);
                                    })
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Prefer Not to Say", style: TextStyle(fontSize: 17)),
                                Checkbox(
                                    value: _q1CheckBoxes[2],
                                    onChanged: (checked) {
                                      _checkBoxTicked(2, checked!);
                                    })
                              ],
                            )
                          ])),
                      const SizedBox(height: 7),
                      const Text(
                          "A Graduation zone in this context means an area of Portsmouth designated on the app to show people's locations.", style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 7),
                      const Text(
                          "Q2. Please arrange the following list of features from most important to you at the top, to least important to you at the bottom (use the handles on the right):", style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child:
                      ReorderableListView(
                          scrollController: ScrollController(),
                          shrinkWrap: true,
                          onReorder: (oldIndex, newIndex) {
                            _onReorder(_q2ReorderableList, oldIndex, newIndex);
                          },
                          children: _q2ReorderableList
                              .map((item) => Text(item, key: Key(item), style: const TextStyle(fontSize: 17)))
                              .toList())),
                      const SizedBox(height: 14),
                      const Text(
                          "Q3. For each of the following potential graduation zones, please selected whether you want it as a zone, don't mind, or don't want it as a zone:", style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 7),
                      Row(children: [
                        Text(_q3List[0]),
                        const SizedBox(width: 7),
                        DropdownButton(
                            value: _q3ButtonsValues[0],
                            items: _q3DropDownItems,
                            onChanged: (text) {
                              _q3Answers[_q3List[0]] = text!.data!;
                              _q3ButtonsValues[0] = text;
                              setState(() {

                              });
                            })
                      ]),
                      Row(children: [
                        Text(_q3List[1]),
                        const SizedBox(width: 7),
                        DropdownButton(
                            value: _q3ButtonsValues[1],
                            items: _q3DropDownItems,
                            onChanged: (text) {
                              _q3Answers[_q3List[1]] = text!.data!;
                              _q3ButtonsValues[1] = text;
                              setState(() {

                              });
                            })
                      ]),
                      Row(children: [
                        Text(_q3List[2]),
                        const SizedBox(width: 7),
                        DropdownButton(
                            value: _q3ButtonsValues[2],
                            items: _q3DropDownItems,
                            onChanged: (text) {
                              _q3Answers[_q3List[2]] = text!.data!;
                              _q3ButtonsValues[2] = text;
                              setState(() {

                              });
                            })
                      ]),
                      const SizedBox(height: 7),
                      const Text(
                          "Q4(Optional). Please enter any other parts of Portsmouth you would like to be designated as graduation zones:", style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 7),
                      TextField(
                        onChanged: (text) {
                          _q4Text = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.0),
                          ),
                          hintText: 'Enter text here...',
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                          "Q5(Optional). Please enter any other features you would like to see in this app:", style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 7),
                      TextField(
                        onChanged: (text) {
                          _q5Text = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 0.0),
                          ),
                          hintText: 'Enter text here...',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ElevatedButton(
                    onPressed: () {
                      bool submitted = _submitResults();
                      if (submitted) {
                        _changeScreen(ScreensEnum.thankYouScreen);
                      } else {
                        setState(() {
                          _q1 = Text(_q1.data!,
                              style: const TextStyle(color: Colors.red, fontSize: 17));
                        });
                      }
                    },
                    child: const Text("Submit", style: TextStyle(fontSize: 17)),
                  ),
                ]))));
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
        _q1CheckBoxes, _q2ReorderableList, _q3Answers, _q4Text, _q5Text);
    if (!answers.answersValid()) {
      return false;
    }
    SendAnswers sendAnswers = SendAnswers();
    sendAnswers.send(answers);
    return true;
  }
}
