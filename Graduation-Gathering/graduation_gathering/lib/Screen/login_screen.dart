import 'package:flutter/material.dart';

/// This holds the screen for the application.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.changeScreen});

  final Function() changeScreen;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// This class contains the GUI structure for the app.
class _LoginScreenState extends State<LoginScreen> {
  String _emailInput = "";
  String _codeInput = "";

  bool _emailErrorTextVisible = false;
  bool _codeAreaVisible = false;

  late Widget _displayedEmailWidgets;

  late Widget _emailWidgets;

  @override
  initState() {
    _emailWidgets = Column(
      children: [
        const Text(
          "Please enter your University email:",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Row(children: [
          Flexible(
              child: TextField(
                onChanged: (text) {
                  _emailInput = text;
                },
                onSubmitted: (text) {
                  _emailEntered(_emailInput);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 0.0),
                  ),
                  hintText: 'Email...',
                ),
              )),
          ElevatedButton(
              onPressed: () {
                _emailEntered(_emailInput);
              },
              child: const Icon(Icons.arrow_outward))
        ]),
      ],
    );
    _displayedEmailWidgets = _emailWidgets;
    super.initState();
  }

  /// Builds the GUI and places the map inside.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffffffff),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _displayedEmailWidgets,
          Visibility(
            visible: _emailErrorTextVisible,
              child: const Text(
                "Must be a valid University of Portsmouth email",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
                textAlign: TextAlign.center,
              )
          ),
          Visibility(
            visible: _codeAreaVisible,
              child: Column(
                children:
                [
          const Text(
            "Please enter the code sent to your email:",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Row(children: [
            Flexible(
                child: TextField(
              onChanged: (text) {
                _codeInput = text;
              },
              onSubmitted: (text) {
                _codeEntered();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                ),
                hintText: 'Code...',
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  _codeEntered();
                },
                child: const Icon(Icons.arrow_outward))
          ]),
                  ElevatedButton(
                      onPressed: () {
                        _sendCode(_emailInput);
                      },
                      child: const Text("Resend code", style: TextStyle(fontSize: 13),)
                  )
                ],))
        ])));
  }

  _emailEntered(String emailInput) {
    emailInput = emailInput.trim();
    String startOfEmail =
        '(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")';
    final studentEmail = RegExp('$startOfEmail@myport.ac.uk');
    final staffEmail = RegExp('$startOfEmail@port.ac.uk');
    if (studentEmail.hasMatch(emailInput) || staffEmail.hasMatch(emailInput)) {
      _emailErrorTextVisible = false;
      _codeAreaVisible = true;
      _displayedEmailWidgets = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text(_emailInput, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ElevatedButton(
                onPressed: () {
                  _displayedEmailWidgets = _emailWidgets;
                  _emailErrorTextVisible = false;
                  _codeAreaVisible = false;
                  _emailInput = "";
                  setState(() {

                  });
                },
                child: const Text("Edit", style: TextStyle(fontSize: 13))
            )
          ]
      );
      _sendCode(emailInput);
    }
    else
    {
      _emailErrorTextVisible = true;
    }
    setState(() {
    });
  }

  _codeEntered() {
    widget.changeScreen();
  }

  _sendCode(String email)
  {
    
  }
}
