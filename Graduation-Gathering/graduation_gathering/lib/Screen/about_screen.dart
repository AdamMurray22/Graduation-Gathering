import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// The about screen widget.
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

/// The about screen state
class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    const double fontSize = 18;
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "This application was made with:",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: fontSize,
                    color: Color(0xff000000),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RichText(
                        key: const Key("Open layers credit"),
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'OpenLayers',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                      Uri(scheme: 'https', host: 'openlayers.org'));
                                },
                            ),
                            const TextSpan(
                              text: ' which is licenced under the ',
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'BSD 2-Clause License.',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri(
                                      scheme: 'https',
                                      host: 'www.tldrlegal.com',
                                      path:
                                      '/license/bsd-2-clause-license-freebsd'));
                                },
                            ),
                            const TextSpan(
                              text: " OpenLayers provides the API to display and "
                                  "manipulate the map in this application.",
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        key: const Key("Open Street Map credit"),
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'OpenStreetMap',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri(
                                      scheme: 'https',
                                      host: 'www.openstreetmap.org'));
                                },
                            ),
                            const TextSpan(
                              text: ' which is licenced under the ',
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Open Data Commons Open Database License.',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri(
                                      scheme: 'https',
                                      host: 'www.openstreetmap.org',
                                      path: '/copyright'));
                                },
                            ),
                            const TextSpan(
                              text:
                              " Open Street Maps provides the data used for the "
                                  "map in this application.",
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        key: const Key("Fix the map"),
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text:
                              "If you find an error with the map please report it ",
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'here.',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri(
                                      scheme: 'https',
                                      host: 'www.openstreetmap.org',
                                      path: '/fixthemap'));
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  key: const Key("My Credit"),
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "This app was developed by Adam Murray. I can be contacted through the following methods:",
                        style: TextStyle(fontSize: fontSize, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 3),
                      RichText(
                        key: const Key("My gmail"),
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Email: adammurray1122@gmail.com',
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        key: const Key("My LinkedIn"),
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'LinkedIn: ',
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'https://www.linkedin.com/in/adam-murray-788625237',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri(
                                      scheme: 'https',
                                      host: 'www.linkedin.com',
                                      path: '/in/adam-murray-788625237'));
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        key: const Key("My Github"),
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Github: ',
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                            ),
                            TextSpan(
                              text: 'https://github.com/AdamMurray22',
                              style: const TextStyle(
                                  fontSize: fontSize, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri(
                                      scheme: 'https',
                                      host: 'github.com',
                                      path: '/AdamMurray22'));
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
