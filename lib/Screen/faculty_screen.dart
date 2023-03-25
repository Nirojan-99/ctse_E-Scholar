import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_scholar/Components/e_button.dart';
import 'package:e_scholar/Components/e_label.dart';
import 'package:e_scholar/Model/faculty.dart';
import 'package:e_scholar/Model/staff.dart';
import 'package:e_scholar/Service/faculty_service.dart';
import 'package:e_scholar/Service/staff_service.dart';
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

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text("Faculty"),
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
                ELabel("Faculty Name"),
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
                  controller: facultyNameController,
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
                      return "enter valid code";
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
                ELabel("HOD"),
                SizedBox(
                  width: double.infinity,
                  // padding: EdgeInsets.all(14),
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
                      items: HODs != null
                          ? HODs!
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
                      value: HOD,
                      onChanged: (value) {
                        setState(() {
                          HOD = value as String;
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
                  height: 30,
                ),
                EButton(_faculty != null ? "Update" : "Add", () {
                  _faculty != null ? updateDetails() : addFacultyData();
                }),
                const SizedBox(
                  height: 10,
                ),
                _faculty != null
                    ? Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: () {
                                deleteFacultyDetails();
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
