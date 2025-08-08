import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/profile_model.dart';

mixin ProfileControllerMixin {
  final ProfileController _profileController = Get.find<ProfileController>();
  ProfileController get profileController => _profileController;
  Profile get profile => _profileController.profile;

  RxBool get isProfileLoading => _profileController.isLoading;
}
