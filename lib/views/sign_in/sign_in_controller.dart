import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/sign_in/models/sign_in_model.dart';

class SignInController extends BaseController {
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController passwordTxtController = TextEditingController();

  Rx<SignInModel> signInModelObj = SignInModel().obs;
  RxBool isShowPassword = false.obs;

  void onSignUpButtonPressed() {
    Get.toNamed(Routes.SIGN_UP);
  }

  void onSignInButtonPressed() {
    Get.toNamed(Routes.MAIN);
  }

  @override
  void onClose() {
    super.onClose();
    emailTxtController.dispose();
    passwordTxtController.dispose();
  }
}
