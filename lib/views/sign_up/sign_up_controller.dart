import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/sign_up/sign_up_model.dart';
import '../../../core/app_export.dart';

class SignUpController extends GetxController {
  TextEditingController emailInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController firstNameInputController = TextEditingController();

  TextEditingController lastNameInputController = TextEditingController();

  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  Rx<bool> isShowPassword = true.obs;

  @override
  void onClose() {
    super.onClose();
    emailInputController.dispose();
    passwordInputController.dispose();
    firstNameInputController.dispose();
    lastNameInputController.dispose();
  }
}
