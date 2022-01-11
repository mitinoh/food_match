import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/onBoarding/authButtons/apple_login.dart';

import 'package:morning_brief/widgets/onBoarding/authButtons/google_login.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    RxBool checked = false.obs;
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/hamburger.png",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 0),
                  child: Text(
                    "foodmatch.",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Expanded(
                    child: Text(
                      "SLOGAN".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: UIColors.lightBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            checkColor: UIColors.green,
                            activeColor: UIColors.green,
                            value: checked.value,
                            onChanged: (bool? value) {
                              checked.value = value!;
                            },
                          ),
                        ),
                        Expanded(
                          child: Text("TERMSANDCONDITIONS".tr,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  color: UIColors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ),
                AppleLogin(onPressed: () {
                  print('Apple Auth');
                }),
                const SizedBox(
                  height: 10,
                ),
                GoogleLogin(
                  checked: checked,
                ),
              ],
            ),
          ),
        ));
  }
}
