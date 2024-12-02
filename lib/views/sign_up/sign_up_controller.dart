import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/views/sign_up/models/sign_up_model.dart';
import '../../core/constants/app_export.dart';

class SignUpController extends BaseController {
  AuthRequest _authRequest = AuthRequest();

  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController firstNameTEC = TextEditingController();
  TextEditingController lastNameTEC = TextEditingController();
  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;
  RxBool isShowPassword = true.obs;

  Future<void> onSignUpButtonPressed(BuildContext context) async {
    final String email = emailTEC.text;
    final String password = passwordTEC.text;
    final String firstName = firstNameTEC.text;
    final String lastName = lastNameTEC.text;

    try {
      if (email != '' && password != '' && firstName != '' && lastName != '') {
        final reponse = await _authRequest.registerRequest(
          email,
          password,
          firstName,
          lastName,
        );
        if (reponse.allGood) {
          AnimatedSnackBar.material(
            'Sign up success'.tr,
            type: AnimatedSnackBarType.success,
          ).show(context);
          goToSignIn();
        } else {
          AnimatedSnackBar.material(
            reponse.error!,
            type: AnimatedSnackBarType.warning,
          ).show(context);
        }
      } else {
        showSnackBarWarning("err_msg_please_enter_valid_text".tr, context);
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        'Sign up fail'.tr,
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  void showSnackBarWarning(String message, BuildContext context) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.warning,
    ).show(context);
  }

  void goToSignIn() {
    Get.toNamed(Routes.SIGN_IN);
  }

  @override
  void onInit() {
    emailTEC.text = kReleaseMode ? "" : "ngodat.it213@gmail.com";
    passwordTEC.text = kReleaseMode ? "" : "Code26102003#!@";
    firstNameTEC.text = kReleaseMode ? "" : "Hydra";
    lastNameTEC.text = kReleaseMode ? "" : "Coder";
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    emailTEC.dispose();
    passwordTEC.dispose();
    firstNameTEC.dispose();
    lastNameTEC.dispose();
  }
}
