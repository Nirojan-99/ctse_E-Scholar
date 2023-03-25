import 'package:e_scholar/Components/info.dart';
import 'package:flutter/material.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({super.key});

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  final _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More Info"),
        elevation: 2,
      ),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          fontFamily: "open sans",
                          fontSize: 19,
                          fontWeight: FontWeight.w700),
                      text: "Take a Quick",
                      children: [
                        TextSpan(
                            text: " Tour",
                            style: TextStyle(color: Color(0xffEEB51D)))
                      ]),
                ),
                const Text(
                    "you will be guided on how to use this app efficiently."),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: PageView(
                controller: _controller,
                children: [
                  Info(1, _controller),
                  Info(2, _controller),
                  Info(3, _controller),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }
}
