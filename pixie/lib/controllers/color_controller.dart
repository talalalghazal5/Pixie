import 'package:get/get.dart';

class ColorController extends GetxController {

  int convertColor(String color) {
    String subColor = color.substring(1,7); // #FF7F50
    int colorCode = int.parse('FF' + subColor, radix: 16);
    return colorCode;
  }
}