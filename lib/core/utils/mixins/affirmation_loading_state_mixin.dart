import 'package:manifest/helper/import.dart';

mixin AffirmationLoadingStateMixin {
  var isTogglingAffirmationVisibility = false.obs;

  void stopTogglingAffirmationVisibility() {
    isTogglingAffirmationVisibility.value = false;
  }

  void startTogglingAffirmationVisibility() {
    isTogglingAffirmationVisibility.value = true;
  }
}