import 'package:get/get.dart';

class CategoriesController {
  static const categoriesAssetsUrl = 'assets/images/categories';
  static const colorsAssetsUrl = 'assets/images/colors';
  List<Map<String, String>> categories = [
    {'name' : 'Animals'.tr, 'value': 'Animals' ,'imagePath' : '$categoriesAssetsUrl/animals.jpg'},
    {'name' : 'Nature'.tr, 'value': 'Nature' ,'imagePath' : '$categoriesAssetsUrl/nature.jpg'},
    {'name' : 'Food'.tr, 'value': 'Food' ,'imagePath' : '$categoriesAssetsUrl/food.jpg'},
    {'name' : 'Architecture'.tr, 'value': 'Architecture' ,'imagePath' : '$categoriesAssetsUrl/architecture.jpg'},
    {'name' : 'Minimal'.tr, 'value': 'Minimal' ,'imagePath' : '$categoriesAssetsUrl/minimal.jpg'},
    {'name' : 'Space'.tr, 'value': 'Space' ,'imagePath' : '$categoriesAssetsUrl/space.jpg'},
  ];
  List<Map<String, String>> colors = [
    {'name' : 'Blue'.tr, 'value': 'Blue' ,'imagePath' : '$colorsAssetsUrl/blue.jpg'},
    {'name' : 'Red'.tr, 'value': 'Red' ,'imagePath' : '$colorsAssetsUrl/red.jpg'},
    {'name' : 'Green'.tr, 'value': 'Green' ,'imagePath' : '$colorsAssetsUrl/green.jpg'},
    {'name' : 'Brown'.tr, 'value': 'Brown' ,'imagePath' : '$colorsAssetsUrl/brown.jpg'},
    {'name' : 'Black'.tr, 'value': 'Black' ,'imagePath' : '$colorsAssetsUrl/black.jpg'},
    {'name' : 'White'.tr, 'value': 'White' ,'imagePath' : '$colorsAssetsUrl/white.jpg'},
  ];
}