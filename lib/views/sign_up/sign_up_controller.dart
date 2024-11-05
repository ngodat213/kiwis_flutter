import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/sign_up/models/sign_up_model.dart';
import '../../core/constants/app_export.dart';

class SignUpController extends BaseController {
  TextEditingController emailInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController firstNameInputController = TextEditingController();

  TextEditingController lastNameInputController = TextEditingController();

  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  RxBool isShowPassword = true.obs;

  void onSignUpButtonPressed() {
    Get.toNamed(Routes.SIGN_IN);
  }

  @override
  void onClose() {
    super.onClose();
    emailInputController.dispose();
    passwordInputController.dispose();
    firstNameInputController.dispose();
    lastNameInputController.dispose();
  }
}
