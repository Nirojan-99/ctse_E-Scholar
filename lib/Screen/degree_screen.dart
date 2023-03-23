import 'package:ctse_app/Components/e_button.dart';
import 'package:ctse_app/Components/e_label.dart';
import 'package:ctse_app/Model/degree.dart';
import 'package:ctse_app/Model/faculty.dart';
import 'package:ctse_app/Model/staff.dart';
import 'package:ctse_app/Service/degree_service.dart';
import 'package:ctse_app/Service/faculty_service.dart';
import 'package:ctse_app/Service/staff_service.dart';
import 'package:ctse_app/Util/validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final items = ["one", "two", "three", "four", "five"];

class DegreeScreen extends StatefulWidget {
  const DegreeScreen({super.key});

  @override
  State<DegreeScreen> createState() => _DegreeScreenState();
}

class _DegreeScreenState extends State<DegreeScreen> {
  List<Staff>? LICs;
  List<Faculty>? faculties;

  //controllers
  final degreeNameController = TextEditingController();
  final codeNumberController = TextEditingController();
  final durationController = TextEditingController();
  String? LIC;
  String? faculty;

  //state
  Degree? _degree;

  @override
  void initState() {
    getFacultyLIC();
    getAllFaculties();
    Future.delayed(Duration.zero, () {
      setState(() {
        _degree = ModalRoute.of(context)?.settings.arguments != null
            ? ModalRoute.of(context)?.settings.arguments as Degree
            : null;

        if (_degree != null) {
          degreeNameController.text = _degree!.degree;
          codeNumberController.text = _degree!.codeNumber;
          durationController.text = _degree!.duration.toString();
          LIC = _degree!.LIC;
          faculty = _degree!.facultyId;
        }
      });
    });

    super.initState();
  }

  addDegreeData() async {
    if (formKey.currentState!.validate()) {
      Degree degree = Degree(
          degree: degreeNameController.text,
          codeNumber: codeNumberController.text,
          LIC: LIC!,
          facultyId: faculty!,
          duration: int.parse(durationController.text));
      bool res = await addDegree("/course/course", degree);
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

  deleteDegreeDetails() {
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
    await deleteDegree("/course/course", _degree!);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  updateDetails() async {
    if (formKey.currentState!.validate()) {
      Degree degree = Degree(
          degree: degreeNameController.text,
          codeNumber: codeNumberController.text,
          LIC: LIC!,
          facultyId: faculty!,
          duration: int.parse(durationController.text),
          id: _degree!.id);

      bool res = await updateDegree("/course/course", degree);
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

  getFacultyLIC() async {
    List<Staff> data = await getStaffs("/staff/HOD");
    setState(() {
      LICs = data;
    });
  }

  getAllFaculties() async {
    List<Faculty> data = await getFaculties("/faculty/faculties");
    setState(() {
      faculties = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text("Degree Program"),
    );
    final double hight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appbar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                ELabel("Degree Program"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter valid name";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: degreeNameController,
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
                ELabel("Code Number"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter valid value";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: codeNumberController,
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
                ELabel("LIC"),
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
                      items: LICs != null
                          ? LICs!
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.firstName,
                                    child: Text(
                                      item.firstName,
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
                      value: LIC,
                      onChanged: (value) {
                        setState(() {
                          LIC = value as String;
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
                ELabel("Duration(years)"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter valid name";
                    } else if (!isNumeric(value)) {
                      return "Require valid number";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: durationController,
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
                  height: 30,
                ),
                EButton(_degree == null ? "Add" : "Update", () {
                  _degree == null ? addDegreeData() : updateDetails();
                }),
                const SizedBox(
                  height: 10,
                ),
                _degree != null
                    ? Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: deleteDegreeDetails,
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
