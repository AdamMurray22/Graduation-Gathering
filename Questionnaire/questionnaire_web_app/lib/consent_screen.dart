import 'package:flutter/material.dart';
import 'package:questionnaire_web_app/screens_enum.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key, required this.changeScreen});

  final Function(int screenIndex) changeScreen;

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    alignment: Alignment.topRight,
                    child: Image.asset('assets/images/UOPLogo.png')),
              Container(
                  alignment: Alignment.center,
                  child:
                ElevatedButton(
                  onPressed: () {
                    _changeScreen(ScreensEnum.termsScreen);
                  },
                  child: const Text("Back To Participant Information Sheet", style: TextStyle(fontSize: 17)),
                ),),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("CONSENT FORM", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    SizedBox(height: 7),
                    Text(
                        "Title of Project: Graduation Gathering", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text(
                        "Name and Contact Details of Researcher: Adam Murray, up2166905@myyport.ac.uk", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text(
                        "Name and Contact Details of Supervisor: Dr Gail Ollis, gail.ollis@port.ac.uk", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text(
                        "University Data Protection Officer: Samantha Hill, 023 9284 3642 or information-matters@port.ac.uk", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text(
                        "Ethics Committee Reference Number: TETHIC-2023-106661", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text("1.	I confirm that I have read and understood the information sheet for this study.", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text("2. 	I understand that my participation is voluntary and that I am free to withdraw at any time without giving any reason until I click submit on the questions page.", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 7),
                    Text(
                        "3. 	I understand that data collected during this study will be processed in accordance with data protection law as explained in the Participant Information Sheet.", style: TextStyle(fontSize: 17)),
                  ],
                ),
                const SizedBox(height: 7),
              Container(
                  alignment: Alignment.center,
                  child:
                ElevatedButton(
                  onPressed: () {
                    _changeScreen(ScreensEnum.questionsScreen);
                  },
                  child: const Text("I agree to take part in the above study", style: TextStyle(fontSize: 17)),
                ),),
              ]),
            )));
  }

  _changeScreen(ScreensEnum screen) {
    widget.changeScreen(screen.screenIndex);
  }
}
