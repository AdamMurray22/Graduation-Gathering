import 'package:flutter/material.dart';
import 'package:graduation_gathering/Login/parse_email.dart';
import 'package:graduation_gathering/Login/send_email.dart';
import 'package:tuple/tuple.dart';

import '../Auth/auth_token.dart';
import '../Login/send_code.dart';

/// The login screen widget.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.changeScreen});

  final Function(AuthToken) changeScreen;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// The login screen state.
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
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(children: [
            Flexible(
                child: TextField(
              onChanged: (text) {
                _emailInput = text;
              },
              onSubmitted: (text) {
                _emailEntered(_emailInput);
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                ),
                hintText: 'Email...',
              ),
            )),
            const SizedBox(width: 5),
            ElevatedButton(
                onPressed: () {
                  _emailEntered(_emailInput);
                },
                child: const Icon(Icons.arrow_outward))
          ]),
        ),
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
        backgroundColor: const Color(0xff009a96),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _displayedEmailWidgets,
          Visibility(
              visible: _emailErrorTextVisible,
              child: const Text(
                "Must be a valid University of Portsmouth email",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
                textAlign: TextAlign.center,
              )),
          Visibility(
              visible: _codeAreaVisible,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Text(
                      "Please enter the code sent to your email:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Row(children: [
                      Flexible(
                          child: TextField(
                        onChanged: (text) {
                          _codeInput = text;
                        },
                        onSubmitted: (text) {
                          _codeEntered(_emailInput, _codeInput);
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.0),
                          ),
                          hintText: 'Code...',
                        ),
                      )),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: () {
                            _codeEntered(_emailInput, _codeInput);
                          },
                          child: const Icon(Icons.arrow_outward))
                    ]),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _sendCode(_emailInput);
                      },
                      child: const Text(
                        "Resend code",
                        style: TextStyle(fontSize: 13),
                      ))
                ],
              ))
        ])));
  }

  // Parses the email and if its valid it sends it too the server.
  _emailEntered(String emailInput) {
    emailInput = emailInput.trim();
    ParseEmail parseEmail = ParseEmail();
    if (parseEmail.validate(emailInput)) {
      _emailErrorTextVisible = false;
      _codeAreaVisible = true;
      _displayedEmailWidgets = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _emailInput,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
                onPressed: () {
                  _displayedEmailWidgets = _emailWidgets;
                  _emailErrorTextVisible = false;
                  _codeAreaVisible = false;
                  _emailInput = "";
                  setState(() {});
                },
                child: const Text("Edit", style: TextStyle(fontSize: 13)))
          ]);
      _sendCode(emailInput);
    } else {
      _emailErrorTextVisible = true;
    }
    setState(() {});
  }

  // Sends the email and code to the server to get the auth token.
  _codeEntered(String email, String code) async {
    SendCode sendCode = SendCode();
    Tuple2<bool, String?> response = await sendCode.send(email, code);
    bool validated = response.item1;
    if (validated) {
      AuthToken authToken = AuthToken(response.item2!);
      widget.changeScreen(authToken);
    }
  }

  // Sends the email.
  _sendCode(String email) {
    SendEmail emailCode = SendEmail();
    emailCode.send(email);
  }
}
