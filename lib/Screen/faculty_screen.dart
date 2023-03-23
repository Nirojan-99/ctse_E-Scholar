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

  addFacultyData() async {
    if (formKey.currentState!.validate()) {
      Faculty newFaculty = Faculty(
          facultyName: facultyNameController.text,
          codeNumber: codeNumberController.text,
          HOD: HOD!);
      bool res = await addFaculty("/faculty/faculty", newFaculty);
      if (res) {
        Navigator.of(context).pop();
      } else {
        // ignore: use_build_context_synchronously
        MotionToast.error(
          description: const Text(
            "Unable to add data!",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          toastDuration: const Duration(milliseconds: 1000),
          animationDuration: const Duration(milliseconds: 400),
        ).show(context);
      }
    }
  }

  deleteFacultyDetails() {
    Alert(
      style: const AlertStyle(
          backgroundColor: Colors.white,
          titleStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
      context: context,
      type: AlertType.info,
      title: "ALERT",
      desc: "Do you want to delete?",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 0, 0, 0),
          child: const Text(
            "No",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          onPressed: () {
            delete();
          },
          color: const Color.fromRGBO(0, 0, 0, 0),
          child: const Text(
            "Yes",
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  delete() async {
    await deleteFaculty("/faculty/faculty", _faculty!);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
  
  updateDetails() async {
    if (formKey.currentState!.validate()) {
      Faculty newFaculty = Faculty(
          facultyName: facultyNameController.text,
          codeNumber: codeNumberController.text,
          HOD: HOD!,
          id: _faculty!.id);

      bool res = await updateFaculty("/faculty/faculty", newFaculty);
      if (res) {
        Navigator.of(context).pop();
      } else {
        // ignore: use_build_context_synchronously
        MotionToast.error(
          description: const Text(
            "Unable to update!",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          toastDuration: const Duration(milliseconds: 1000),
          animationDuration: const Duration(milliseconds: 400),
        ).show(context);
      }
    }
  }

  final formKey = GlobalKey<FormState>();
