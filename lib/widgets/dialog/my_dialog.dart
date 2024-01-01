import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/widgets/loading/loading_custom.dart';

class MyDialog {
  /// Info.
  static void info(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: AppColors.darkBg.withOpacity(.75),
      colorText: AppColors.whiteText.withOpacity(.85),
      borderRadius: 12,
      icon: const Icon(
        Icons.keyboard,
        color: AppColors.lightBg,
      ),
    );
  }

  /// Failure.
  static void failure(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: AppColors.errorBg.withOpacity(.75),
      colorText: AppColors.whiteText.withOpacity(.85),
      borderRadius: 12,
      icon: const Icon(
        Icons.error,
        color: AppColors.lightBg,
      ),
    );
  }

  /// Success.
  static void success(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: AppColors.successBg.withOpacity(.75),
      colorText: AppColors.whiteText.withOpacity(.85),
      borderRadius: 12,
      icon: const Icon(
        Icons.check,
        color: AppColors.lightBg,
      ),
    );
  }

  /// Loading.
  static void showLoadingDialog() {
    Get.dialog(const Center(child: LoadingCustom()));
  }
}
