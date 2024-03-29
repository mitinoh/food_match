import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/utils/UIColors.dart';

class FilterBody extends StatelessWidget {
  FilterBody({Key? key}) : super(key: key);

  static RxList<int> listFilters = RxList<int>().obs();

  List<Widget> getFilters() {
    List<Widget> filters = [];
    DishType.values.forEach((el) {
      filters.add(InkWell(
        onTap: () => {
          (!listFilters.contains(el.index))
              ? listFilters.add(el.index)
              : listFilters.remove(el.index),
          //if (listFilters.length == 0) listFilters.add(-1),
          MenuController.instance.getMenuList(listFilters)
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color: listFilters.contains(el.index)
                    ? UIColors.violetMain
                    : UIColors.detailBlack,
                borderRadius: BorderRadius.circular(20)),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: listFilters.contains(el.index)
                        ? UIColors.violetMainlightOption
                        : UIColors.black.withOpacity(0.6),
                    child: Icon(
                      el.icon,
                      color: UIColors.white,
                    ), //free_breakfast dinner_dining
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      el.name.toString().tr,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    });
    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1,
            children: getFilters(),
          ),
        ));
  }
}
