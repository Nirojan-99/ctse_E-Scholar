import 'package:ctse_app/Model/student.dart';
import 'package:ctse_app/Service/student_service.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  var functionName = getStudents("/student/students");
  final searchController = TextEditingController();

  onSearch() {
    setState(() {
      functionName =
          getStudentsByName("/student/search", searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Students"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/single student");
            },
            icon: const Icon(
              Icons.add,
            ),
            splashRadius: 20,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: const TextSpan(
                style: TextStyle(
                    fontFamily: "open sans",
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
                text: "Students of",
                children: [
                  TextSpan(
                      text: " SLIIT",
                      style: TextStyle(color: Color(0xffEEB51D)))
                ]),
          ),
          const Text(
            "Manage all the undergraduates and post-graduates details here.",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: "open sans"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "open sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  controller: searchController,
                  cursorColor: Colors.white,
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: "search...",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xff4b576f),
                      filled: true),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  onSearch();
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xff4b576f)),
                    child: IconButton(
                      onPressed: () {
                        onSearch();
                      },
                      icon: const Icon(Icons.search),
                      color: const Color(0xffEEB51D),
                      splashRadius: 20,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder<List<Student>>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Student>? students = snapshot.data;

                  if (students!.isEmpty) {
                    return const Center(
                      child: Text("No data"),
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/single student",
                              arguments: students[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xff4A576F),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(0xFF0F1E3D),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "images/staff.png",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            title: Text(
                              "${students[index].firstName} - ${students[index].idNumber}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "open sans"),
                            ),
                            subtitle: Text(students[index].role,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "open sans")),
                            trailing: const Icon(
                              Icons.double_arrow_rounded,
                              color: Color(0xffEEB51D),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: students!.length,
                  );
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No Data"),
                  );
                }
              },
              future: functionName,
            ),
          ),
        ]),
      ),
    );
  }
}
