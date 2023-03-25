import 'package:ctse_app/Components/e_button.dart';
import 'package:ctse_app/Components/e_label.dart';
import 'package:ctse_app/Model/degree.dart';
import 'package:ctse_app/Model/faculty.dart';
import 'package:ctse_app/Model/student.dart';
import 'package:ctse_app/Service/degree_service.dart';
import 'package:ctse_app/Service/faculty_service.dart';
import 'package:ctse_app/Service/student_service.dart';
import 'package:ctse_app/Util/validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// final items = ["one", "two", "three", "four", "five"];

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  Student? _student;
  List<Faculty>? faculties;
  List<Degree>? degrees;

  //form data
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final idController = TextEditingController();
  final academicYearController = TextEditingController();
  String? faculty;
  String? degree;
  var division = "UnderGraduate";

  addStudentDetails() async {
    if (formKey.currentState!.validate()) {
      Student student = Student(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          contactNumber: int.parse(contactNumberController.text),
          idNumber: idController.text,
          facultyId: faculty!,
          degreeId: degree!,
          role: division,
          academicYear: int.parse(academicYearController.text));
      bool res = await addStudent("/student/student", student);
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

  deleteStudentDetails() {
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
    await deleteStudent("/student/student", _student!);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  updateDetails() async {
    if (formKey.currentState!.validate()) {
      Student student = Student(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          contactNumber: int.parse(contactNumberController.text),
          idNumber: idController.text,
          facultyId: faculty!,
          degreeId: degree!,
          role: division,
          academicYear: int.parse(academicYearController.text),
          id: _student!.id);

      bool res = await updateStudent("/student/student", student);
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

  @override
  void initState() {
    getAllFaculties();
    getAllDegrees();
    Future.delayed(Duration.zero, () {
      setState(() {
        _student = ModalRoute.of(context)?.settings.arguments != null
            ? ModalRoute.of(context)?.settings.arguments as Student
            : null;

        if (_student != null) {
          firstNameController.text = _student!.firstName;
          lastNameController.text = _student!.lastName;
          emailController.text = _student!.email;
          contactNumberController.text = _student!.contactNumber.toString();
          faculty = _student!.facultyId;
          division = _student!.role;
          idController.text = _student!.idNumber;
          degree = _student!.degreeId;
          academicYearController.text = _student!.academicYear.toString();
        }
      });
    });

    super.initState();
  }

  getAllFaculties() async {
    List<Faculty> data = await getFaculties("/faculty/faculties");
    setState(() {
      faculties = data;
    });
  }

  getAllCourses() async {
    List<Degree> data = await getDegreesByFaculty("/course/faculty", faculty!);
    setState(() {
      degrees = data;
    });
  }

  getAllDegrees() async {
    List<Degree> data = await getDegrees("/course/courses");
    setState(() {
      degrees = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text("Student"),
    );
    //size
    final double hight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appbar,
      body: Container(
        width: double.infinity,
        height: hight,
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff4A576F),
                  ),
                  child: Image.asset(
                    "images/staff.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ELabel("First Name"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Require valid value";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: firstNameController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("Last Name"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Require valid value";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: lastNameController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("Email"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Require valid value";
                    } else if (!isValidEmail(value)) {
                      return "Require valid email";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("Contact Number"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Require valid value";
                    } else if (!isNumeric(value)) {
                      return "Require valid number";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: contactNumberController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("ID Number"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Require valid value";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: idController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("Faculty"),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: faculties != null
                          ? faculties!
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.facultyName,
                                    child: Text(
                                      item.facultyName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList()
                          : null,
                      value: faculty,
                      onChanged: (value) {
                        setState(() {
                          faculty = value as String;
                          getAllCourses();
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xff4A576F),
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.white,
                        ),
                        iconSize: 14,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(0xff4A576F),
                          ),
                          elevation: 8,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("Degree Program"),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: degrees != null
                          ? degrees!
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.degree,
                                    child: Text(
                                      item.degree,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList()
                          : null,
                      value: degree,
                      onChanged: (value) {
                        setState(() {
                          degree = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xff4A576F),
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.white,
                        ),
                        iconSize: 14,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(0xff4A576F),
                          ),
                          elevation: 8,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ELabel("Academic Year"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Require valid value";
                    } else if (!isNumeric(value)) {
                      return "Require valid number";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: academicYearController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          division = "UnderGraduate";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff4A576F),
                            border: division == "UnderGraduate"
                                ? Border.all(color: Colors.blue, width: 3)
                                : Border.all(
                                    color: const Color(0xff4A576F), width: 3)),
                        child: const Text(
                          "UnderGraduate",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "open sans",
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          division = "PostGraduate";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff4A576F),
                            border: division == "PostGraduate"
                                ? Border.all(color: Colors.blue, width: 3)
                                : Border.all(
                                    color: const Color(0xff4A576F), width: 3)),
                        child: const Text(
                          "PostGraduate",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "open sans",
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                EButton(_student != null ? "Update" : "Add", () {
                  _student != null ? updateDetails() : addStudentDetails();
                }),
                const SizedBox(
                  height: 10,
                ),
                _student != null
                    ? Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: () {
                                deleteStudentDetails();
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
