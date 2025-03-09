
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  Map<dynamic, dynamic> categories = {};
  List<String> category = [
    "sad",
    "pop",
    "party",
    "romantic",
    "marathi"
  ];

  void setCategories(Map<dynamic, dynamic> categoryData) {
    categories = categoryData;
  }

  List<Map<dynamic, dynamic>> fetchCategories() {
    List<Map<dynamic, dynamic>> categoryList = [];
    for(String cat in category){
      Map<dynamic, dynamic> categoryData = categories[cat];
      categoryList.add(categoryData);
      
    }

    return categoryList;
  }
}
