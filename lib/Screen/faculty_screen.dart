import 'package:ctse_app/Components/e_button.dart';
import 'package:ctse_app/Components/e_label.dart';
import 'package:ctse_app/Model/faculty.dart';
import 'package:ctse_app/Model/staff.dart';
import 'package:ctse_app/Service/faculty_service.dart';
import 'package:ctse_app/Service/staff_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// final items = ["one", "two", "three", "four", "five", "Nirojan", "Abiramy"];

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  Faculty? _faculty;
  List<Staff>? HODs;

  //form data
  final facultyNameController = TextEditingController();
  final codeNumberController = TextEditingController();
  String? HOD;

  getFacultyHOD() async {
    List<Staff> data = await getStaffs("/staff/HOD");
    setState(() {
      HODs = data;
    });
  }

  @override
  void initState() {
    getFacultyHOD();
    Future.delayed(Duration.zero, () {
      setState(() {
        _faculty = ModalRoute.of(context)?.settings.arguments != null
            ? ModalRoute.of(context)?.settings.arguments as Faculty
            : null;

        if (_faculty != null) {
          facultyNameController.text = _faculty!.facultyName;
          codeNumberController.text = _faculty!.codeNumber;
          HOD = _faculty!.HOD;
        }
      });
    });

    super.initState();
  }
