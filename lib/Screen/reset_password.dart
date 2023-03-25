import 'package:e_scholar/Components/e_button.dart';
import 'package:e_scholar/Components/e_error_message.dart';
import 'package:e_scholar/Components/e_label.dart';
import 'package:e_scholar/Model/user.dart';
import 'package:e_scholar/Service/user_service.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _passwordController = TextEditingController();
  final _reTypedPasswordController = TextEditingController();
  String passwordError = "";
  String reTypedPasswordError = "";
  double hight = 0;
  late User user;

  submitHandler() async {
    setState(() {
      hight = 0;
    });
    if (_passwordController.text != _reTypedPasswordController.text) {
      setState(() {
        hight = 20;
      });
    } else {
      User? res = await resetPassword(
          "/user/password", user.email, _passwordController.text);
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        //TODO
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ELabel("New Password"),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "open sans",
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              controller: _passwordController,
              cursorColor: Colors.white,
              maxLines: 1,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                  errorText: passwordError != "" ? passwordError : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xff4b576f),
                  filled: true),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ELabel("Re-Type password"),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "open sans",
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              controller: _reTypedPasswordController,
              cursorColor: Colors.white,
              maxLines: 1,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                  errorText:
                      reTypedPasswordError != "" ? reTypedPasswordError : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xff4b576f),
                  filled: true),
            ),
            ErrorMessage(hight, "Passwords didn't match"),
            SizedBox(
              height: height * 0.04,
            ),
            EButton("Submit", () {
              submitHandler();
            })
          ],
        ),
      ),
    );
  }
}
