import 'package:ctse_app/Components/e_button.dart';
import 'package:ctse_app/Components/e_error_message.dart';
import 'package:ctse_app/Components/e_label.dart';
import 'package:ctse_app/Model/user.dart';
import 'package:ctse_app/Service/user_service.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  //states
  late User user;
  final _OTPController = TextEditingController();
  bool otpError = false;
  double hight = 0;

  submitHandler() async {
    setState(() {
      hight = 0;
    });
    User? userReturned =
        await checkOTP("/user/otp", user.email, _OTPController.text);
    if (userReturned != null) {
      Navigator.pushReplacementNamed(context, "/reset password",
          arguments: user);
    } else {
      setState(() {
        hight = 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ELabel("OTP"),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              obscureText: true,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "open sans",
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              controller: _OTPController,
              cursorColor: Colors.white,
              maxLines: 1,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                  errorText: otpError ? "Invalid value" : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xff4b576f),
                  filled: true),
            ),
            ErrorMessage(hight, "Invalid OTP"),
            SizedBox(
              height: height * 0.04,
            ),
            EButton("Submit", () {
              submitHandler();
            })
          ],
        ),
      )),
    );
  }
}
