import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/change_password/models/change_password.model.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordInputController = TextEditingController();
  TextEditingController newPasswordInputController = TextEditingController();

  TextEditingController confirmNewPasswordInputController =
      TextEditingController();

  Rx<ChangePasswordModel> changePasswordModelObj = ChangePasswordModel().obs;

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isShowPassword1 = true.obs;
  Rx<bool> isShowPassword2 = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    oldPasswordInputController.dispose();
    newPasswordInputController.dispose();
    confirmNewPasswordInputController.dispose();
  }
}
