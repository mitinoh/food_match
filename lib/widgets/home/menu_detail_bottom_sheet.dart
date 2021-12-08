import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';

class DetailBottomSheet extends GetWidget<MenuController> {
  DetailBottomSheet({Key? key, required this.menu, required this.ingredients})
      : super(key: key);
  final MenuModel menu;
  final List<IngredientModel>? ingredients;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    int index = 0;
    return Container(
      height: mediaQuery.size.height * 0.85,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: UIColors.detailBlack),
      child: Column(children: [
        Container(
            width: 60,
            child: Divider(height: 5, color: UIColors.black, thickness: 4)),
        SizedBox(
          height: 30,
        ),
        Expanded(
            child: ListView(
          children: [
            Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(menu.kcal.toString(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text('kcal',
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(menu.difficulty.toString(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text('livello',
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(menu.preparationTime.toString(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text('ore',
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: UIColors.white,
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                      fit: BoxFit.cover,
                      height: mediaQuery.size.height * 0.2,
                      width: mediaQuery.size.width * 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                /*Row(
                  children: [
                    Text(menu.menuName.toString(),
                        style: GoogleFonts.poppins(
                            color: UIColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),*/
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      menu.note.toString(),
                      style: GoogleFonts.poppins(
                          color: UIColors.pink,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Ingredienti",
                      style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var item in menu.ingredients)
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                    item!.qty.toString() +
                                        item.unit +
                                        " " +
                                        controller.getIngredientName(
                                            item.id.toString(), ingredients),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.poppins(
                                        color: UIColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Procedimento",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (var item in menu.steps)
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VerticalDivider(
                                width: 30,
                                thickness: 4,
                                color: UIColors.pink,
                              ),
                              Expanded(
                                child: Text(
                                    menu.steps.indexOf(item).toString() + item,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.poppins(
                                        color: UIColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.updateSavedMenu(menu.id);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            size: 25,
                            color: UIColors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Piatto cucinato',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )),
      ]),
    );
  }
}
