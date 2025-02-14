class CategoriesController {
  static const categoriesAssetsUrl = 'assets/images/categories';
  static const colorsAssetsUrl = 'assets/images/colors';
  static List<Map<String, String>> categories = [
    {'name' : 'Animals', 'imagePath' : '$categoriesAssetsUrl/animals.jpg'},
    {'name' : 'Nature', 'imagePath' : '$categoriesAssetsUrl/nature.jpg'},
    {'name' : 'Food', 'imagePath' : '$categoriesAssetsUrl/food.jpg'},
    {'name' : 'Architecture', 'imagePath' : '$categoriesAssetsUrl/architecture.jpg'},
    {'name' : 'Minimal', 'imagePath' : '$categoriesAssetsUrl/minimal.jpg'},
    {'name' : 'Space', 'imagePath' : '$categoriesAssetsUrl/space.jpg'},
  ];
  static List<Map<String, String>> colors = [
    {'name' : 'Blue', 'imagePath' : '$colorsAssetsUrl/blue.jpg'},
    {'name' : 'Red', 'imagePath' : '$colorsAssetsUrl/red.jpg'},
    {'name' : 'Green', 'imagePath' : '$colorsAssetsUrl/green.jpg'},
    {'name' : 'Brown', 'imagePath' : '$colorsAssetsUrl/brown.jpg'},
    {'name' : 'Black', 'imagePath' : '$colorsAssetsUrl/black.jpg'},
    {'name' : 'White', 'imagePath' : '$colorsAssetsUrl/white.jpg'},
  ];
}