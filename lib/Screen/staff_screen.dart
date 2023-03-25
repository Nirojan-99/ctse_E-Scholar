import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_scholar/Components/e_button.dart';
import 'package:e_scholar/Components/e_error_message.dart';
import 'package:e_scholar/Components/e_label.dart';
import 'package:e_scholar/Model/faculty.dart';
import 'package:e_scholar/Model/staff.dart';
import 'package:e_scholar/Service/faculty_service.dart';
import 'package:e_scholar/Service/staff_service.dart';
import 'package:e_scholar/Util/validator.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:motion_toast/motion_toast.dart';

// final items = ["one", "two", "three", "four", "five"];

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final roles = [
    "Professor",
    "Lecturer",
    "Senior Lecturer",
    "Visiting Lecturer",
    "Instructor",
    "Demo"
  ];
  final sectors = [
    "Security",
    "Canteen",
    "Cleaning",
    "management",
    "Any",
  ];

  List<Faculty>? faculties;

  //fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  String? faculty;
  String? role;
  String? sector;
  String division = "Academic";

  //state
  double animatedHight = 0;
  Staff? _staff;

//submit handler;
  submitHandler() async {
    if (formKey.currentState!.validate()) {
      Staff staff = Staff(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        contactNumber: int.parse(contactNumberController.text),
        division: division,
        faculty: division == "Academic" ? faculty : null,
        role: division == "Academic" ? role : null,
        sector: division == "Non-Academic" ? sector : null,
      );
      bool res = await addStaff("/staff/staff", staff);
      if (res) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          animatedHight = 20;
        });
      }
    }
  }

  getAllFaculties() async {
    List<Faculty> data = await getFaculties("/faculty/faculties");
    setState(() {
      faculties = data;
    });
  }

  @override
  void initState() {
    getAllFaculties();
    Future.delayed(Duration.zero, () {
      setState(() {
        _staff = ModalRoute.of(context)?.settings.arguments != null
            ? ModalRoute.of(context)?.settings.arguments as Staff
            : null;

        if (_staff != null) {
          firstNameController.text = _staff!.firstName;
          lastNameController.text = _staff!.lastName;
          emailController.text = _staff!.email;
          contactNumberController.text = _staff!.contactNumber.toString();
          faculty = _staff!.faculty;
          role = _staff!.role;
          sector = _staff!.sector;
          division = _staff!.division;
        }
      });
    });

    super.initState();
  }

  deleteStaffDetails() {
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
    await deleteStaff("/staff/staff", _staff!);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  updateDetails() async {
    if (formKey.currentState!.validate()) {
      Staff staff = Staff(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          contactNumber: int.parse(contactNumberController.text),
          division: division,
          faculty: division == "Academic" ? faculty : null,
          role: division == "Academic" ? role : null,
          sector: division == "Non-Academic" ? sector : null,
          id: _staff!.id);

      bool res = await updateStaff("/staff/staff", staff);
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

  //form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text("Staff"),
    );
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
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.phone,
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          division = "Academic";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff4A576F),
                            border: division == "Academic"
                                ? Border.all(color: Colors.blue, width: 3)
                                : Border.all(
                                    color: const Color(0xff4A576F), width: 3)),
                        child: const Text(
                          "Academic",
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
                          division = "Non-Academic";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff4A576F),
                            border: division == "Non-Academic"
                                ? Border.all(color: Colors.blue, width: 3)
                                : Border.all(
                                    color: const Color(0xff4A576F), width: 3)),
                        child: const Text(
                          "Non-Academic",
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
                division == "Academic"
                    ? Column(
                        children: [
                          ELabel("Faculty"),
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
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
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
                          ELabel("Role"),
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
                                items: roles
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value as String;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 160,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
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
                        ],
                      )
                    : Column(
                        children: [
                          ELabel("Sector"),
                          Container(
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
                                items: sectors
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: sector,
                                onChanged: (value) {
                                  setState(() {
                                    sector = value as String;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 160,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
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
                        ],
                      ),
                const SizedBox(
                  height: 30,
                ),
                EButton(_staff != null ? "Update" : "Add", () {
                  _staff != null ? updateDetails() : submitHandler();
                }),
                ErrorMessage(animatedHight, "Unable to add staff details!"),
                const SizedBox(
                  height: 10,
                ),
                _staff != null
                    ? Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: () {
                                deleteStaffDetails();
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
