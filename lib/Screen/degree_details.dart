import 'package:ctse_app/Model/degree.dart';
import 'package:ctse_app/Service/degree_service.dart';
import 'package:flutter/material.dart';

class DegreeDetails extends StatefulWidget {
  const DegreeDetails({super.key});

  @override
  State<DegreeDetails> createState() => _DegreeDetailsState();
}

class _DegreeDetailsState extends State<DegreeDetails> {
  @override
  void didUpdateWidget(covariant DegreeDetails oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Degree Program"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/single degree");
              },
              icon: const Icon(Icons.add))
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
                      text: "Degree programs of",
                      children: [
                        TextSpan(
                            text: " SLIIT",
                            style: TextStyle(color: Color(0xffEEB51D)))
                      ]),
                ),
                const Text(
                  "Manage all the degree program details here.",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "open sans"),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<List<Degree>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Data"),
                  );
                }
                List<Degree>? data = snapshot.data;
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 100),
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
                          Navigator.pushNamed(context, "/single degree",
                              arguments: data[index]);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[index].degree.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "roboto",
                                    fontSize: 16,
                                    color: Color(0xffEEB51D)),
                              ),
                              FittedBox(
                                child: Text(
                                  data[index].facultyId,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "open sans",
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
            future: getDegrees("/course/courses"),
          )),
        ],
      ),
    );
  }
}
