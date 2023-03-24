import 'package:ctse_app/Model/faculty.dart';
import 'package:ctse_app/Service/faculty_service.dart';
import 'package:flutter/material.dart';

class FacultyDetails extends StatefulWidget {
  const FacultyDetails({super.key});

  @override
  State<FacultyDetails> createState() => _FacultyDetailsState();
}

class _FacultyDetailsState extends State<FacultyDetails> {
  var functionName = getFaculties("/faculty/faculties");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty"),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/single faculty");
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            splashRadius: 20,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          fontFamily: "open sans",
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                      text: "Faculty of",
                      children: [
                        TextSpan(
                            text: " SLIIT",
                            style: TextStyle(color: Color(0xffEEB51D)))
                      ]),
                ),
                const Text(
                  "Manage all the staff details here.",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "open sans"),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<List<Faculty>>(
            future: functionName,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No data"),
                  );
                }
                List<Faculty>? data = snapshot.data;
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 50),
                  itemCount: data!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 2),
                      decoration: BoxDecoration(
                          color: const Color(0xff4A576F),
                          borderRadius: BorderRadius.circular(8)),
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, "/single faculty",
                              arguments: data[index]);
                        },
                        child: Center(
                          child: Container(
                            child: Text(
                              data[index].facultyName.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "roboto",
                                  fontSize: 15,
                                  color: Color(0xffEEB51D)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else {
                return const Center(
                  child: Text("No data availabe"),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
