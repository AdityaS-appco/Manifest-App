// lib/controllers/progress_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:manifest/view/widgets/arc_progress_widget/arc_progress_widget_model/arc_progress_model.dart';

class ProgressController extends GetxController with GetSingleTickerProviderStateMixin {
  // Model instance
  final ProgressModel _progressModel = ProgressModel();

  // Observable progress value
  RxDouble get progress => _progressModel.progress.obs;

  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    // Initialize the AnimationController
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Listen to animation updates and update progress
    animationController.addListener(() {
      _progressModel.progress = animationController.value;
      progress.value = _progressModel.progress;
    });

    // Start the animation
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  // Method to reset and restart the animation
  void resetProgress() {
    animationController.reset();
    animationController.forward();
  }

  // Optional: Method to set progress manually
  void setProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      _progressModel.progress = value;
      progress.value = value;
    }
  }
}
