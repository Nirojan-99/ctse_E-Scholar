import 'package:ctse_app/Screen/dashboard.dart';
import 'package:ctse_app/Screen/degree_details.dart';
import 'package:ctse_app/Screen/degree_screen.dart';
import 'package:ctse_app/Screen/error_screen.dart';
import 'package:ctse_app/Screen/faculty_details.dart';
import 'package:ctse_app/Screen/faculty_screen.dart';
import 'package:ctse_app/Screen/forgot_password.dart';
import 'package:ctse_app/Screen/login_screen.dart';
import 'package:ctse_app/Screen/module_details.dart';
import 'package:ctse_app/Screen/module_screen.dart';
import 'package:ctse_app/Screen/more_info.dart';
import 'package:ctse_app/Screen/network_error.dart';
import 'package:ctse_app/Screen/otp_screen.dart';
import 'package:ctse_app/Screen/register_screen.dart';
import 'package:ctse_app/Screen/reset_password.dart';
import 'package:ctse_app/Screen/splash_screen.dart';
import 'package:ctse_app/Screen/staff_details_screen.dart';
import 'package:ctse_app/Screen/staff_screen.dart';
import 'package:ctse_app/Screen/student_screen.dart';
import 'package:ctse_app/Screen/students_details_screen.dart';
import 'package:ctse_app/Theme/custom_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      home: const SplashScreen(),
      routes: {
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/forgot password": (context) => const ForgotPasswordScreen(),
        "/otp": (context) => const OTPScreen(),
        "/reset password": (context) => const ResetPassword(),
        "/error": (context) => const ErrorScreen(),
        "/net error": (context) => const NetworkError(),
        "/dashboard": (context) => const Dashboard(),
        "/staff": (context) => const StaffDetails(),
        "/single staff": (context) => const StaffScreen(),
        "/single student": (context) => const StudentScreen(),
        "/single faculty": (context) => const FacultyScreen(),
        "/single degree": (context) => const DegreeScreen(),
        "/single module": (context) => const ModuleScreen(),
        "/students": (context) => const StudentsList(),
        "/faculties": (context) => const FacultyDetails(),
        "/degree program": (context) => const DegreeDetails(),
        "/digital library": (context) => const Dashboard(),
        "/notices": (context) => const Dashboard(),
        "/modules": (context) => const ModuleDetails(),
        "/more info": (context) => const MoreInfo(),
        "/setting": (context) => const Dashboard(),
      },
    );
  }
}
