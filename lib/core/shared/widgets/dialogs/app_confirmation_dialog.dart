import 'package:flutter/material.dart';
import 'package:manifest/helper/import.dart';

class AppConfirmationDialog extends StatelessWidget {
  AppConfirmationDialog({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onDismiss,
    this.confirmButtonText = 'Delete',
    this.dismissButtonText = 'Cancel',
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback? onDismiss;
  final String confirmButtonText;
  final String dismissButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff1d2125),
      title: Text(
        title,
        style: customTextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        message,
        style: customTextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        maxLines: 5,
      ),
      actions: [
        TextButton(
          onPressed: onDismiss ?? Get.back,
          child: Text(
            dismissButtonText,
            style: customTextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            confirmButtonText,
            style: customTextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
