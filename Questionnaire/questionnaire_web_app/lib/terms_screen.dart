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
      child: Column(children: [
        Container(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/UOPLogo.png')),
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PARTICIPANT INFORMATION SHEET"),
            Text(
                "Name and Contact Details of Researcher: Adam Murray, up2166905@myyport.ac.uk"),
            Text(
                "Name and Contact Details of Supervisor: Dr Gail Ollis, gail.ollis@port.ac.uk"),
            Text("1.	Invitation"),
            Text(
                "I am a final year student studying Computer Science BSc at the University Of Portsmouth. I would like to invite you to take part in my research study. Joining the study is entirely up to you, before you decide I would like you to understand why the research is being done and what it would involve for you. Please feel free to talk to others about the study if you wish. Taking part will take about 5 minutes. Please ask/contact us if you have any questions."),
            Text("2. 	Study Summary"),
            Text(
                "The purpose of this study is to understand what features both members of staff and students of the University Of Portsmouth desire from an app designed to connect them on graduation day. This study will require you to complete the following activities: "),
            Text("1.	Access the website via your preferred browser"),
            Text(
                "2.	Input whether you are a student or member of staff at the University Of Portsmouth (Prefer not to say will also be an option)"),
            Text("3.	Prioritise a couple lists of features"),
            Text(
                "4.	If you have additional ideas about where you would like graduation zones, list them"),
            Text("5.	Agree to this Participant Information Sheet"),
            Text("6.	Click Submit"),
            Text(
                "3. 	What data will be collected and / or measurements taken? "),
            Text(
                "The only data that will be collected will be your answer to whether you are a member of staff or a student, as well as a list of ID numbers relating to the features you have ordered on the website and finally the text that you input for the question asking about any ideas from you, about where you would like graduation zones to be designated. All data stored about you will be fully anonymised. Data will be stored securely on a google drive that can only be accessed by members of the research team. It will be deleted after the end of the project."),
            Text("4. 	Do I have to take part? "),
            Text(
                "No, taking part in this research is entirely voluntary. It is up to you to decide if you want to volunteer for the study. You can still withdraw from the study at any time for any reason even after you have agreed to the term and conditions."),
            Text("5. 	Expenses and payments "),
            Text("There is no payment for taking part."),
            Text("6. What if there is a problem?"),
            Text(
                "If you have a query, concern or complaint about any aspect of this study, in the first instance you should contact the researcher if appropriate. If there is a complaint and there is a supervisor listed, please contact the Supervisor with details of the complaint. The contact details for both the researcher and any supervisor are detailed above."),
            Text("Thank you"),
            Text(
                "Thank you for taking time to read this information sheet and for considering volunteering for this research."),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            _changeScreen();
          },
          child: const Text("I Agree To Participate"),
        ),
      ]),
    ));
  }

  _changeScreen() {
    widget.changeScreen(ScreensEnum.questionsScreen.screenIndex);
  }
}
