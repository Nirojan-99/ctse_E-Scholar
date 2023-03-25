import 'package:e_scholar/Components/e_button.dart';
import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width * 0.8,
                child: Image.asset("images/signal.png"),
              ),
              const Text(
                "Ooops!",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  fontFamily: "open sans",
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  "It seems there is something wrong with your internet connection, Please connect to the internet and start the app again",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                width: width * 0.5,
                child: EButton("Try Again", () {
                  Navigator.of(context).pop();
                }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
