import 'package:ctse_app/Components/e_button.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

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
                child: Image.asset("images/error.png"),
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
                  "It seems there is something wrong with the server, Try again later",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                width: width*0.5,
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
