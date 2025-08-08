import 'package:get/get.dart';

class NavBarController extends GetxController {
  // Using RxInt to make it reactive
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}