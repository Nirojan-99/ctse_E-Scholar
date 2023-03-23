import 'package:ctse_app/Screen/degree_details.dart';
import 'package:ctse_app/Screen/degree_screen.dart';

import 'package:ctse_app/Screen/faculty_details.dart';
import 'package:ctse_app/Screen/faculty_screen.dart';

import 'package:flutter/material.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Scholar',
      theme: customDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
      routes: {
        "/single faculty": (context) => const FacultyScreen(),
        "/single degree": (context) => const DegreeScreen(),
        "/faculties": (context) => const FacultyDetails(),
        "/degree program": (context) => const DegreeDetails(),
      },
    );
  }
}
