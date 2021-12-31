import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import "package:get/get.dart";

class PreviewPageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/images/previewA.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "TIREDOFCOOKING".tr +
                  " \n" +
                  "ALWAYSTHESAME".tr +
                  " \n" +
                  "THINGS".tr +
                  "?",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "WEGOTTHESOLUTION".tr + "!",
              style: GoogleFonts.poppins(
                  color: UIColors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )
          ],
        ));
  }
}
