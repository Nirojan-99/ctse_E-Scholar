import 'package:ctse_app/Components/e_button.dart';
import 'package:ctse_app/Components/e_error_message.dart';
import 'package:ctse_app/Components/e_label.dart';
import 'package:ctse_app/Model/user.dart';
import 'package:ctse_app/Service/user_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  String emailErrorText = '';
  double errorBoxHight = 0;

  //handler function
  submitHandler() async {
    setState(() {
      errorBoxHight = 0;
    });
    User? user = await checkMail("/user/validate", emailController.text);
    if (user != null) {
      Navigator.pushNamed(context, "/otp", arguments: user);
    } else {
      setState(() {
        errorBoxHight = 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Reset Password"),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ELabel("Email"),
                TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: emailController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                      errorText: emailErrorText != "" ? emailErrorText : null,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                ErrorMessage(errorBoxHight, "Invalid Email"),
                SizedBox(
                  height: height * 0.04,
                ),
                EButton("Send OTP", () {
                  submitHandler();
                })
              ],
            )),
      ),
    );
  }
}
