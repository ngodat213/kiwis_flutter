import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressDialogUtils {
  static bool isPregressVisible = false;

  /// comon method for showing progress dialog
  static void showProgressDialog({bool isCancellable = false}) async {
    if (!isPregressVisible) {
      Get.dialog(
          Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          barrierDismissible: isCancellable);

      isPregressVisible = true;
    }
  }

  /// common mehtod for hiding progress dialog
  static void hideProgressDialog() {
    if (isPregressVisible) Get.back();
    isPregressVisible = false;
  }
}
