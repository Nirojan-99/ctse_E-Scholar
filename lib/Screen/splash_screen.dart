import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _paddingTop = 200;
  double _opacity = 0.2;
  final int _duration = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          _paddingTop = 0;
          _opacity = 1;
        }));
    _navigateScreen();
  }

  _navigateScreen() {
    Future.delayed(Duration(seconds: _duration + 2)).then((value) {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).splashColor,
      child: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: _duration),
          curve: Curves.fastOutSlowIn,
          padding: EdgeInsets.only(top: _paddingTop),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: width * .2),
          child: AnimatedOpacity(
            opacity: _opacity,
            curve: Curves.fastOutSlowIn,
            duration: Duration(seconds: _duration),
            child: Image.asset(
              "images/logo2.png",
            ),
          ),
        ),
      ),
    );
    ;
  }
}
