import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/sign_in/models/sign_in_model.dart';

class SignInController extends BaseController {
  AuthRequest _authRequest = AuthRequest();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController passwordTxtController = TextEditingController();

  Rx<SignInModel> signInModelObj = SignInModel().obs;
  RxBool isShowPassword = false.obs;

  void onSignUpButtonPressed() {
    Get.toNamed(Routes.SIGN_UP);
  }

  void onSignInButtonPressed(BuildContext context) async {
    final email = emailTxtController.text;
    final password = passwordTxtController.text;

    try {
      if (email != '' && password != '') {
        final apiResponse =
            await _authRequest.loginRequest(email: email, password: password);
        if (apiResponse.allGood) {
          await _handleDeviceLogin(apiResponse, context);
        } else {
          AnimatedSnackBar.material(
            apiResponse.error!,
            type: AnimatedSnackBarType.warning,
          ).show(context);
        }
      } else {
        AnimatedSnackBar.material(
          'Email and password is required'.tr,
          type: AnimatedSnackBarType.info,
        ).show(context);
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        'Login error'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    }
  }

  Future<void> _handleDeviceLogin(
    ApiResponse apiResponse,
    BuildContext context,
  ) async {
    try {
      final token = apiResponse.body;
      final userCredential =
          await fbAuth.FirebaseAuth.instance.signInWithCustomToken(token);

      fbAuth.User? user = userCredential.user;

      if (user != null) {
        String? idToken = await user.getIdToken();
        await AuthServices.setAuthBearerToken(idToken);
        await AuthServices.isAuthenticated();
        await _handleCurrentUser(idToken!, context);
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        'Login error'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    }
  }

  Future<void> _handleCurrentUser(String idToken, BuildContext context) async {
    try {
      final apiResponse =
          await _authRequest.curentUserRequest(idToken: idToken);

      if (apiResponse.allGood) {
        await AuthServices.saveUser(apiResponse.body);
        Get.offAndToNamed(Routes.MAIN);
        AnimatedSnackBar.material(
          'Login success'.tr,
          type: AnimatedSnackBarType.warning,
        ).show(context);
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        'Get current error'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    }
  }

  @override
  void onInit() {
    emailTxtController.text = kReleaseMode ? "" : "ngodat.it213@gmail.com";
    passwordTxtController.text = kReleaseMode ? "" : "Code26102003";
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    emailTxtController.dispose();
    passwordTxtController.dispose();
  }
}
