import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:get/get.dart';

class AppleLogin extends GetWidget<AuthController> {
  AppleLogin({Key? key, required this.checked}) : super(key: key);
  final RxBool checked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
      ),
      child: GestureDetector(
        //onTap: () => signInWithGoogle(context),
        onTap: () => {
          HapticFeedback.mediumImpact(),
          if (checked.value)
            {AuthController.instance.signInWithApple(false)}
          else
            {
              Get.snackbar("ACCEPTTHETERMS".tr + ".", "MUSTACCEPT".tr,
                  colorText: UIColors.white)
            }
        }, //_authController.signInWithGoogle(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.apple,
                  size: 30,
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            text: 'CONTINUEWITH'.tr,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 17),
                            children: <TextSpan>[
                              TextSpan(
                                text: " Apple",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              )
                            ]),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
