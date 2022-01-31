import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';

import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class InventoryScreen extends StatelessWidget {
  bool isValueUpdated = false;
  RxList<String> _userInventory = RxList();
  IngredientController ingController =
      Get.put<IngredientController>(IngredientController());

  updateStock(state, index) {
    /*
    UserInventory inv =
        _userInventory.where((el) => el.id == state.ingSearch[index].id).single;

    bool stock = stocked ? inv.stock = true : inv.stock = false;
    */
    String id = state.ingSearch[index].id;
    if (!_userInventory.contains(id))
      _userInventory.add(id);
    else
      _userInventory.removeWhere((el) => el == id);

    // print(_userInventory);
    // MenuController().updateStockCtrl(_userInventory);
    // _userInventory.refresh();
  }

  setUserInventoryCheck() {
    ingController.userIngredients?.forEach((el) {
      _userInventory.add(el);
    });
  }

  bool getStock(state, index) {
    if (_userInventory.contains(state.ingSearch[index].id)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    setUserInventoryCheck();
    ingController.filterIngredients("");
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //if (mediaQuery.viewInsets.bottom == 0)
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("INVENTORY".tr,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                        Container(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              color: UIColors.detailBlack,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            child: Text("DONE".tr.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.violet,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                            onPressed: () {
                              if (isValueUpdated) {
                                MenuController()
                                    .updateStockCtrl(_userInventory);
                                MenuController.instance
                                    .getMenuList(FilterBody.listFilters);
                              }

                              HapticFeedback.mediumImpact();
                              Get.back();
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: UIColors.lightBlack.withOpacity(0.5)),
                child: ListView(children: <Widget>[
                  CupertinoSearchTextField(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, right: 20, left: 10),
                    onChanged: (text) {
                      ingController.filterIngredients(text);
                    },
                    autofocus: false,
                    style: GoogleFonts.poppins(
                        color: UIColors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                    itemSize: 30,
                    placeholder: 'TEXTFIELDLABELINVENTORY'.tr,
                    prefixInsets: EdgeInsets.only(left: 20),
                    suffixInsets: EdgeInsets.only(right: 20),
                    itemColor: UIColors.violet,
                    placeholderStyle: GoogleFonts.poppins(
                        color: UIColors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => GetX<IngredientController>(
                        init: Get.put<IngredientController>(
                            IngredientController()),
                        builder: (IngredientController ingCtrl) {
                          if (ingCtrl.ingSearch.length > 0) {
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ingCtrl.ingSearch.length,
                              itemBuilder: (_, index) {
                                // setUserInventoryCheck(ingCtrl, index);
                                return Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: UIColors.lightBlack,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Obx(
                                      () => CheckboxListTile(
                                        checkColor: UIColors.green,
                                        activeColor: UIColors.green,
                                        title: Text(
                                          ingCtrl.ingSearch[index].name
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                            getStock(ingCtrl, index)
                                                ? "AVAIBLEINTHEKITCHEN"
                                                    .tr
                                                    .toLowerCase()
                                                : "NOTAVAIBLEINTHEKITCHEN"
                                                    .tr
                                                    .toLowerCase(),
                                            style: GoogleFonts.poppins(
                                                color: getStock(ingCtrl, index)
                                                    ? UIColors.lightGreen
                                                    : UIColors.orange,
                                                fontWeight: FontWeight.w300)),
                                        value: getStock(ingCtrl, index),
                                        onChanged: (bool? value) {
                                          updateStock(ingCtrl, index);
                                          isValueUpdated = true;
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      ),
                                    ));
                              },
                            );
                          } else {
                            //ingCtrl.filterIngredients("");
                            return LoadingWidget();
                          }
                        },
                      )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
