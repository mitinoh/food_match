import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/settings_screen.dart';

import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/filters.dart';
import 'package:morning_brief/widgets/inventory/inventory_page.dart';

import 'filters_header.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topLeft,
      color: theme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Ciao',
                style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                ', ${FirebaseAuth.instance.currentUser!.displayName!.split(' ')[0]}',
                style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      Get.to(() => SettingsScreen());
                      //Get.to(() => StatsPage());
                    },
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: UIColors.detailBlack,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: UIColors.white,
                      ),
                      onPressed: () {
                        Get.to(() => FiltersPage());
                      },
                    ),
                  ),
                  FilterHeader.listFilters.length > 0
                      ? Positioned(
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: UIColors.darkPurple,
                          ),
                          top: -3,
                          right: -3,
                        )
                      : Text("")
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_outlined,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      /*Get.bottomSheet(InventoryBottomSheet(),
                      isScrollControlled: true);*/
                      Get.offAll(() => InventoryScreen());
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
