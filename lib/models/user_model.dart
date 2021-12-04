import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String name;
  late List<String> allergies;
  late DateTime lastShop;
  late int dinnerTime;
  UserModel(
      {required this.id,
      required this.name,
      required this.allergies,
      required this.lastShop,
      required this.dinnerTime});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "allergies,": allergies,
      "lastShop": lastShop,
      "dinnerTime": dinnerTime,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      id: parsedJson['id'],
      name: parsedJson['name'],
      allergies: parsedJson['allergies'],
      lastShop: parsedJson['lastShop'],
      dinnerTime: parsedJson['dinnerTime'],
    );
  }

  UserModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"] ?? "";
    allergies = documentSnapshot["allergies"].cast<String>() ?? [];
    lastShop = documentSnapshot["lastShop"].toDate() ?? DateTime.now();
    dinnerTime = documentSnapshot["dinnerTime"] ?? 0;
  }
}

extension UserExtensions on QueryDocumentSnapshot {
  UserModel get touser => UserModel(
        id: this.id,
        name: this['name'],
        allergies: this['allergies'],
        lastShop: this['lastShop'],
        dinnerTime: this['dinnerTime'],
      );
}