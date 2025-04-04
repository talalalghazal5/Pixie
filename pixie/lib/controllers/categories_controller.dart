import 'package:get/get.dart';
import 'package:pixie/bindings/my_bindings.dart';

class CategoriesController {
  static const categoriesAssetsUrl = 'assets/images/categories';
  static const colorsAssetsUrl = 'assets/images/colors';
  static List<Map<String, String>> categories = [
    {'name' : 'animalsCategoryCard'.tr, 'imagePath' : '$categoriesAssetsUrl/animals.jpg'},
    {'name' : 'natureCategoryCard'.tr, 'imagePath' : '$categoriesAssetsUrl/nature.jpg'},
    {'name' : 'foodCategoryCard'.tr, 'imagePath' : '$categoriesAssetsUrl/food.jpg'},
    {'name' : 'architectureCategoryCard'.tr, 'imagePath' : '$categoriesAssetsUrl/architecture.jpg'},
    {'name' : 'minimalCategoryCard'.tr, 'imagePath' : '$categoriesAssetsUrl/minimal.jpg'},
    {'name' : 'spaceCategoryCard'.tr, 'imagePath' : '$categoriesAssetsUrl/space.jpg'},
  ];
  static List<Map<String, String>> colors = [
    {'name' : 'blueCategoryCard'.tr, 'imagePath' : '$colorsAssetsUrl/blue.jpg'},
    {'name' : 'redCategoryCard'.tr, 'imagePath' : '$colorsAssetsUrl/red.jpg'},
    {'name' : 'greenCategoryCard'.tr, 'imagePath' : '$colorsAssetsUrl/green.jpg'},
    {'name' : 'brownCategoryCard', 'imagePath' : '$colorsAssetsUrl/brown.jpg'},
    {'name' : 'blackCategoryCard', 'imagePath' : '$colorsAssetsUrl/black.jpg'},
    {'name' : 'whiteCategoryCard', 'imagePath' : '$colorsAssetsUrl/white.jpg'},
  ];
}