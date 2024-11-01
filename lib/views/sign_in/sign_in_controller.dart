import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/views/sign_in/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<SignInModel> signInModelObj = SignInModel().obs;
  Rx<bool> isShowPassword = false.obs;

  void onSignUpButtonPressed() {
    Get.toNamed(Routes.SIGN_UP);
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
