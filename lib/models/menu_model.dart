import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class MenuModel {
  late String id;
  late String name;
  late int kcal;
  late int difficulty;
  late int preparationTime;
  late List<String> allergies;
  late List<String> steps;
  late List<MenuIngredientModel?> ingredients;
  late String note;
  late int dishType;
  late String linkUrl;

  MenuModel(
      {required this.id,
      required this.name,
      required this.kcal,
      required this.difficulty,
      required this.preparationTime,
      required this.allergies,
      required this.steps,
      required this.ingredients,
      required this.note,
      required this.dishType,
      required this.linkUrl});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name" + conf.lang: name,
      "kcal": kcal,
      "difficulty,": difficulty,
      "preparationTime": preparationTime,
      "allergies": allergies,
      "steps" + conf.lang: steps,
      "ingredients": ingredients.map((e) => e?.toMap()).toList(),
      "note" + conf.lang: note,
      "dishType": dishType,
      "linkUrl": linkUrl,
      "insertionDate": DateTime.now()
    };
  }

  Map<String, dynamic> toCookedMap() {
    return {
      "id": id,
      "name": name,
      "kcal": kcal,
      "dishType": dishType,
      "preparationTime": preparationTime,
      "cookedTime": DateTime.now()
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> parsedJson) {
    return MenuModel(
        id: parsedJson["id"],
        name: parsedJson['name' + conf.lang],
        kcal: parsedJson['kcal'],
        difficulty: parsedJson['difficulty'],
        preparationTime: parsedJson['preparationTime'],
        allergies: parsedJson['allergies'],
        steps: parsedJson['steps' + conf.lang],
        ingredients: parsedJson['ingredients'],
        note: parsedJson['note' + conf.lang],
        dishType: parsedJson['dishType'],
        linkUrl: parsedJson['linkUrl']);
  }

  MenuModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = conf.docContains("name" + conf.lang, documentSnapshot)
        ? documentSnapshot["name" + conf.lang]
        : '';
    kcal = conf.docContains("kcal", documentSnapshot)
        ? documentSnapshot["kcal"]
        : 0;
    difficulty = conf.docContains("difficulty", documentSnapshot)
        ? documentSnapshot["difficulty"]
        : 0;
    preparationTime = conf.docContains("preparationTime", documentSnapshot)
        ? documentSnapshot["preparationTime"]
        : 0;
    allergies = conf.docContains("allergies", documentSnapshot)
        ? documentSnapshot["allergies"].cast<String>()
        : [];
    steps = conf.docContains("steps" + conf.lang, documentSnapshot)
        ? documentSnapshot["steps" + conf.lang].cast<String>()
        : [];
    note = conf.docContains("note" + conf.lang, documentSnapshot)
        ? documentSnapshot["note" + conf.lang]
        : "";
    dishType = conf.docContains("dishType", documentSnapshot)
        ? documentSnapshot["dishType"]
        : -1;
    linkUrl = conf.docContains("linkUrl", documentSnapshot)
        ? documentSnapshot["linkUrl"]
        : "https://images.pexels.com/photos/1565982/pexels-photo-1565982.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";

    ingredients = conf.docContains("ingredients", documentSnapshot)
        ? List<MenuIngredientModel>.from(
            documentSnapshot["ingredients"].map((item) {
            return new MenuIngredientModel(
                id: item["id"], qty: item["qty"], unit: item["unit"]);
          }))
        : [];
  }
}

extension MenuExtensions on QueryDocumentSnapshot {
  MenuModel get touser => MenuModel(
        id: this.id,
        name: this['menu' + conf.lang],
        kcal: this['kcal'],
        difficulty: this['difficulty'],
        preparationTime: this['preparationTime'],
        allergies: this['allergies'],
        steps: this['steps' + conf.lang],
        ingredients: this['ingredients'],
        note: this['note' + conf.lang],
        dishType: this['dishType'],
        linkUrl: this['linkUrl'],
      );
}
