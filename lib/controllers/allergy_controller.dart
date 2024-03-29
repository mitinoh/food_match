import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/allergyChecked_model.dart';
import 'package:morning_brief/models/allergy_model.dart';
import 'package:morning_brief/services/allergy_database.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';

class AllergyController extends GetxController {
  static AllergyController instance = Get.find();
  Rxn<AllergyModel> allergy = Rxn<AllergyModel>();
  Rxn<List<AllergyModel>> allergyList = Rxn<List<AllergyModel>>().obs();
  List<AllergyModel>? get allergies => allergyList.value.obs();

  Rxn<List<String>> userAllergyList = Rxn<List<String>>().obs();
  List<String>? get userAllergies => userAllergyList.value.obs();

  RxList<AllergyChecked> _isChecked = RxList();
  bool isValueUpdated = false;

  @override
  void onInit() {
    super.onInit();
    allergyList.bindStream(DatabaseAllergy().allergiesStream());
    userAllergyList.bindStream(DatabaseAllergy().userAllergiesStream());
  }

  Future<bool> updateAllergies(RxList isChecked) async {
    return DatabaseAllergy().updateAllergies(isChecked);
  }

  setAllergies(allergyController, isFirstLogin) {
    MenuController _menuController;
    try {
      _menuController = MenuController.instance;
    } catch (e) {
      _menuController = Get.put<MenuController>(MenuController());
    }

    allergyController.updateAllergies(_isChecked).then((value) => {
          if (!isFirstLogin) _menuController.getMenuList(FilterBody.listFilters)
        });
  }

  getAllergyName(allergyController, index) {
    return allergyController.allergies![index].name.toString();
  }

  getCheckValue(allergyController, index) {
    return _isChecked
        .where((el) => el.id == allergyController.allergies![index].id)
        .single
        .checked;
  }

  setCheckState(state, index, newValue) {
    _isChecked
        .where((el) => el.id == state.allergies[index].id)
        .single
        .checked = newValue!;

    _isChecked.refresh();

    if (!isValueUpdated) {
      isValueUpdated = true;
    }
  }

  setAllergiesCheck(state, index) {
    if (_isChecked.where((el) => el.id == state.allergies[index].id).isEmpty) {
      _isChecked.add(AllergyChecked(
          id: state.allergies[index].id,
          checked: state.userAllergies != null
              ? state.userAllergies.contains(state.allergies[index].id)
              : false));
    }
  }
}
