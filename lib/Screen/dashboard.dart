import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Data> list = [
    Data("Staff", "academic & non academic", "images/staff.png"),
    Data("Students", "", "images/student-f.png"),
    Data("Faculties", "", "images/university.png"),
    Data("Degree Program", "", "images/bachelors-degree.png"),
    Data("Digital Library", "", "images/bookshelf.png"),
    Data("Notices", "messages & announcements", "images/feedback.png"),
    Data("Modules", "", "images/book.png"),
    Data("More Info", "help information", "images/question.png"),
    Data("Setting", "customize setting", "images/gear.png"),
  ];
  var prefs;

  initSP() async {
    prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');
  }

  logOut() async {
    await prefs.remove("token");
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  void initState() {
    initSP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Admin Dashboard",
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/logo.png",
              height: 10,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff4A576F),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF0F1E3D),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      splashRadius: 20,
                      splashColor: Colors.white,
                    )
                  ],
                ),
              ),
              //body
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFF0F1E3D),
                        ),
                        child: const Icon(
                          Icons.dashboard,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF0F1E3D),
                          ),
                          child: const Text(
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "open sans",
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFF0F1E3D),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF0F1E3D),
                          ),
                          child: const Text(
                            "Account",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "open sans",
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFF0F1E3D),
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          logOut();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF0F1E3D),
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "open sans",
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30),
            itemCount: list.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                decoration: BoxDecoration(
                    color: const Color(0xff4A576F),
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(
                        context, "/${list[index].title.toLowerCase()}");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 45,
                        child: Image.asset(
                          list[index].image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FittedBox(
                        child: Text(
                          list[index].title.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "roboto",
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        list[index].subtitle.isNotEmpty
                            ? "(${list[index].subtitle})"
                            : "",
                        style: const TextStyle(
                            fontSize: 8,
                            fontFamily: "open sans",
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class Data {
  late String title;
  late String subtitle;
  late String image;
  Data(this.title, this.subtitle, this.image);
}
