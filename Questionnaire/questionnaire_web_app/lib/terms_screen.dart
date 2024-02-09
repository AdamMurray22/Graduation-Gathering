import 'package:flutter/material.dart';
import 'package:questionnaire_web_app/screens_enum.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key, required this.changeScreen});

  final Function(int screenIndex) changeScreen;

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(children: [
        Container(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/UOPLogo.png')),
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PARTICIPANT INFORMATION SHEET", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Text(
                "Name and Contact Details of Researcher: Adam Murray, up2166905@myyport.ac.uk", style: TextStyle(fontSize: 17)),
            Text(
                "Name and Contact Details of Supervisor: Dr Gail Ollis, gail.ollis@port.ac.uk", style: TextStyle(fontSize: 17)),
            Text("1.	Invitation", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                  "I am a final year student studying Computer Science BSc at the University Of Portsmouth. I would like to invite you to take part in my research study. Joining the study is entirely up to you, before you decide I would like you to understand why the research is being done and what it would involve for you. Please feel free to talk to others about the study if you wish. Taking part will take about 5 minutes. Please ask/contact us if you have any questions.", style: TextStyle(fontSize: 17)),
            ),
            Text("2. 	Study Summary", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                      "The purpose of this study is to understand what features both members of staff and students of the University Of Portsmouth desire from an app designed to connect them on graduation day.", style: TextStyle(fontSize: 17)),
                ])),
            Text(
                "3. 	What data will be collected and / or measurements taken? ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                  "The only data that will be collected will be your answer to whether you are a member of staff or a student, as well as a list of ID numbers relating to the features you have ordered on the website, IDs for which graduation zones you want, and finally the text that you input for the question asking about any ideas from you, about where you would like graduation zones to be designated. No personally identifiable data will be collected. Data will be stored securely on a google drive that can only be accessed by members of the research team. It will be deleted after the end of the project.", style: TextStyle(fontSize: 17)),
            ),
            Text("4. 	Do I have to take part? ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                  "No, taking part in this research is entirely voluntary. It is up to you to decide if you want to volunteer for the study. You can still withdraw from the study at any time for any reason until you click submit on the questions page.", style: TextStyle(fontSize: 17)),
            ),
            Text("5. 	Expenses and payments ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text("There is no payment for taking part.", style: TextStyle(fontSize: 17)),
            ),
            Text("6. What if there is a problem?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                  "If you have a query, concern or complaint about any aspect of this study, in the first instance you should contact the researcher if appropriate. If there is a complaint please contact the Supervisor with details of the complaint. The contact details for both the researcher and any supervisor are detailed above.", style: TextStyle(fontSize: 17)),
            ),
            Text("Thank you", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Text(
                "Thank you for taking time to read this information sheet and for considering volunteering for this research.", style: TextStyle(fontSize: 17)),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            _changeScreen();
          },
          child: const Text("I Agree To Participate", style: TextStyle(fontSize: 17)),
        ),
      ]),
    )));
  }

  _changeScreen() {
    widget.changeScreen(ScreensEnum.questionsScreen.screenIndex);
  }
}
