import 'package:ctse_app/Model/staff.dart';
import 'package:ctse_app/Service/staff_service.dart';
import 'package:flutter/material.dart';

class StaffDetails extends StatefulWidget {
  const StaffDetails({super.key});

  @override
  State<StaffDetails> createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {
  //state
  List<Staff>? staffs;
  final searchTextController = TextEditingController();

  //function to get all staff
  var functionName = getStaffs("/staff/staffs");

  //search handler
  onClickSearch() {
    setState(() {
      functionName =
          getStaffsByName("/staff/search", searchTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Staffs"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/single staff");
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
                text: "Staff of",
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
                  controller: searchTextController,
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
                  onClickSearch();
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xff4b576f)),
                    child: IconButton(
                      onPressed: () {
                        onClickSearch();
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
              child: FutureBuilder<List<Staff>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Staff>? data = snapshot.data;

                if (data!.isEmpty) {
                  return const Center(
                    child: Text("No data found"),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/single staff",
                            arguments: data[index]);
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
                            data![index].firstName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontFamily: "open sans"),
                          ),
                          subtitle: Text(
                              data![index].role ?? data![index].sector!,
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
                  itemCount: data!.length,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                return const Center(child: Text("No data"));
              }
            },
            future: functionName,
          )),
        ]),
      ),
    );
  }
}
