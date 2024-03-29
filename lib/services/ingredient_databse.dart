import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseIngredient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Stream<List<IngredientModel>> ingredientStream() {
    try {
      return _firestore
          .collection(conf.inventoryListCollection)
          .snapshots()
          .map((QuerySnapshot query) {
        List<IngredientModel> retVal = [];
        for (var element in query.docs) {
          element['ingredients'].forEach((el) =>
              {retVal.add(IngredientModel.fromListDocumentSnapshot(el))});
        }
        retVal.sort((a, b) => a.name.compareTo(b.name));
        return retVal;
      });
    } catch (e) {
      Get.snackbar(
        "Error getting ingredients",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }

  Future<bool> updateIngredients(RxList isChecked) async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    try {
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .update({"ingredients": getIngredientsId(isChecked)});
      return true;
    } catch (e) {
      Get.snackbar(
        "Error updating ingredients",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }


    List<String> getIngredientsId(RxList isChecked) {
    List<String> ingredients = [];
    isChecked.forEach((el) {
      if (el.checked) ingredients.add(el.id);
    });
    return ingredients;
  }
}
