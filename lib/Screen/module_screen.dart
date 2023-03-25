import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ctse_app/Components/e_button.dart';
import 'package:ctse_app/Components/e_label.dart';
import 'package:ctse_app/Model/degree.dart';
import 'package:ctse_app/Model/module.dart';
import 'package:ctse_app/Model/staff.dart';
import 'package:ctse_app/Service/degree_service.dart';
import 'package:ctse_app/Service/module_service.dart';
import 'package:ctse_app/Service/staff_service.dart';
import 'package:ctse_app/Util/validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final items = ["one", "two", "three", "four", "five"];

// class ModuleScreen extends StatefulWidget {
//   const ModuleScreen({super.key});

//   @override
//   State<ModuleScreen> createState() => _ModuleScreenState();
// }

class _ModuleScreenState extends State<ModuleScreen> {
  List<Staff>? LICs;
  List<Degree>? degrees;
  //controllers
  final moduleNameController = TextEditingController();
  final moduleCodeController = TextEditingController();
  final durationController = TextEditingController();
  final enrolmentController = TextEditingController();
  String? course;
  String? LIC;

  //
  Module? _module;

  @override
  void initState() {
    getFacultyLIC();
    getAllFaculties();
    Future.delayed(Duration.zero, () {
      setState(() {
        _module = ModalRoute.of(context)?.settings.arguments != null
            ? ModalRoute.of(context)?.settings.arguments as Module
            : null;

        if (_module != null) {
          moduleNameController.text = _module!.moduleName;
          moduleCodeController.text = _module!.moduleCode;
          durationController.text = _module!.duration.toString();
          enrolmentController.text = _module!.enrolmentKey;
          course = _module!.courseId;
          LIC = _module!.LIC;
        }
      });
    });

    super.initState();
  }

  addModuleData() async {
    if (formKey.currentState!.validate()) {
      Module module = Module(
          moduleName: moduleNameController.text,
          moduleCode: moduleCodeController.text,
          LIC: LIC!,
          enrolmentKey: enrolmentController.text,
          duration: int.parse(durationController.text),
          courseId: course!);
      bool res = await addModule("/module/module", module);
      if (res) {
        Navigator.of(context).pop();
      } else {
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.material(
          'Unable to add data',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          duration: const Duration(milliseconds: 600),
        ).show(context);
      }
    }
  }

  deleteModuleDetails() {
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
    await deleteModule("/module/module", _module!);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  updateDetails() async {
    if (formKey.currentState!.validate()) {
      Module module = Module(
          moduleName: moduleNameController.text,
          moduleCode: moduleCodeController.text,
          LIC: LIC!,
          enrolmentKey: enrolmentController.text,
          duration: int.parse(durationController.text),
          courseId: course!,
          id: _module!.id);

      bool res = await updateModule("/module/module", module);
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
    List<Degree> data = await getDegrees("/course/courses");
    setState(() {
      degrees = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Module"),
      ),
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
                ELabel("Module Name"),
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
                  controller: moduleNameController,
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
                ELabel("Module Code"),
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
                  controller: moduleCodeController,
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
                ELabel("Course"),
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
                      value: course,
                      onChanged: (value) {
                        setState(() {
                          course = value as String;
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
                ELabel("Enrolment Key"),
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
                  controller: enrolmentController,
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
                ELabel("Duration(week)"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter valid value";
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
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                EButton(_module != null ? "Update" : "Add", () {
                  _module != null ? updateDetails() : addModuleData();
                }),
                const SizedBox(
                  height: 10,
                ),
                _module != null
                    ? Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                              onPressed: () {
                                deleteModuleDetails();
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
    ;
  }
}
