import 'package:ctse_app/Components/e_button.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  late int index;
  late PageController controller;
  Info(this.index, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14, left: 14),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff4A576F),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              "images/staff.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            "Staff".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Color(0xffEEB51D),
            ),
          ),
          const Text(
            "All the Staff who are working in SLIIT will be listed here.",
            style: TextStyle(
                fontSize: 15,
                fontFamily: "open sans",
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          BulletList(
              "You can search for a particular student and do needed modification."),
          BulletList("User-friendly UI makes the operation fast."),
          BulletList("Easy navigation provided."),
          BulletList("Better icons used."),
          const SizedBox(
            height: 20,
          ),
          EButton("Next", () {
            controller.animateToPage(index ,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 500));
          })
        ],
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  late String point;
  BulletList(this.point, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xffEEB51D)),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              point,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "open sans",
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
