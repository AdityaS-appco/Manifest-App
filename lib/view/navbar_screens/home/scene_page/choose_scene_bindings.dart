import 'package:get/get.dart';
import 'package:manifest/view/navbar_screens/home/scene_page/choose_scene_controller.dart';

class ChooseSceneBinding extends Bindings {
  final String selectedImage;

  ChooseSceneBinding({required this.selectedImage});

  @override
  void dependencies() {
    Get.lazyPut(() => ChooseSceneController(selectedImage: selectedImage));
  }
}
