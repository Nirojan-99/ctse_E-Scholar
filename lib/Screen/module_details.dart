import 'package:ctse_app/Model/module.dart';
import 'package:ctse_app/Service/module_service.dart';
import 'package:flutter/material.dart';

class ModuleDetails extends StatefulWidget {
  const ModuleDetails({super.key});

  @override
  State<ModuleDetails> createState() => _ModuleDetailsState();
}

class _ModuleDetailsState extends State<ModuleDetails> {
  var functionName = getModules("/module/modules");
  final searchController = TextEditingController();

  onSearch() {
    setState(() {
      functionName = getModuleByName("/module/search", searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modules"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/single module");
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 10, bottom: 5, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          fontFamily: "open sans",
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                      text: "Modules of",
                      children: [
                        TextSpan(
                            text: " SLIIT",
                            style: TextStyle(color: Color(0xffEEB51D)))
                      ]),
                ),
                const Text(
                  "Manage all the module details here.",
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
                      width: 8,
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
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<List<Module>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No data"),
                  );
                }
                List<Module>? data = snapshot.data;

                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
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
                          Navigator.pushNamed(context, "/single module",
                              arguments: data[index]);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[index].moduleName.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "roboto",
                                    fontSize: 16,
                                    color: Color(0xffEEB51D)),
                              ),
                              FittedBox(
                                child: Text(
                                  data[index].courseId,
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
                  child: Text("No data"),
                );
              }
            },
            future: functionName,
          )),
        ],
      ),
    );
  }
}
