import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaku/utils/extension/string.dart';
import 'package:kaku/utils/extension/widget.dart';
import 'On_board.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: 'Kaku'.boldText( color: Colors.white,
        fontSize: 40,).center()
    );
  }
}
