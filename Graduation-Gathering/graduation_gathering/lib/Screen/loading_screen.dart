import 'package:flutter/material.dart';

/// Loading Screen Widget.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

// Loading Screen state.
class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff009a96),
      body: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0xff009a96),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.27),
            Image.asset('assets/images/Loading Image.png',
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            const Text(
              "Loading...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}