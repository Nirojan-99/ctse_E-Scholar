import 'package:e_scholar/Components/e_button.dart';
import 'package:e_scholar/Components/e_error_message.dart';
import 'package:e_scholar/Components/e_label.dart';
import 'package:e_scholar/Model/user.dart';
import 'package:e_scholar/Service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppBar _appBar = AppBar(
    title: const Text("Login"),
  );

  //error messages
  String emailErrorText = "";
  String passwordErrorText = "";
  double invalidLoginHight = 0;

  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //login handler
  login() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      invalidLoginHight = 0;
    });
    User? user = await loginService(
        "/user/login", emailController.text, passwordController.text);
    if (user != null) {
      await prefs.setString('token', user.token);
      Navigator.pushReplacementNamed(context, "/dashboard");
    } else {
      setState(() {
        invalidLoginHight = 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
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
            ELabel("Password"),
            TextField(
              autocorrect: false,
              obscureText: true,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "open sans",
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              controller: passwordController,
              cursorColor: Colors.white,
              maxLines: 1,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                  errorText: passwordErrorText != "" ? passwordErrorText : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0xff4b576f),
                  filled: true),
            ),
            ErrorMessage(invalidLoginHight, "Invalid Credentials"),
            SizedBox(
              height: height * 0.04,
            ),
            EButton("Login", login),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forgot password");
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.red),
                    )),
                Expanded(
                  child: Container(),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: const Text(
                      "Don't have account?",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
