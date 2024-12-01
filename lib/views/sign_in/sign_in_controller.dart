import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/requests/user.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/sign_in/models/sign_in_model.dart';

class SignInController extends BaseController {
  AuthRequest _authRequest = AuthRequest();
  UserRequest _userRequest = UserRequest();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController passwordTxtController = TextEditingController();
  // Form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<SignInModel> signInModelObj = SignInModel().obs;
  RxBool isShowPassword = false.obs;

  @override
  void onInit() {
    emailTxtController.text = kReleaseMode ? "" : "ngodat.it213@gmail.com";
    passwordTxtController.text = kReleaseMode ? "" : "Code26102003#!@";
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    emailTxtController.dispose();
    passwordTxtController.dispose();
  }

  void onSignUpButtonPressed() {
    Get.toNamed(Routes.SIGN_UP);
  }

  void onPressedForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void onSignInButtonPressed(BuildContext context) async {
    final email = emailTxtController.text;
    final password = passwordTxtController.text;
    late ApiResponse apiResponse;
    try {
      if (formKey.currentState!.validate()) {
        apiResponse =
            await _authRequest.loginRequest(email: email, password: password);
        if (apiResponse.allGood) {
          await _handleDeviceLogin(apiResponse, context);
        } else {
          AnimatedSnackBar.material(
            apiResponse.error!,
            type: AnimatedSnackBarType.warning,
          ).show(context);
        }
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
      final firebaseToken = apiResponse.body['firebaseToken'];
      final token = apiResponse.body['token'];
      // Login with firebase
      await _handleLoginWithFirebase(firebaseToken, context);
      // Save token BE
      await _handleLogin(token, context);

      Get.offAndToNamed(Routes.MAIN);
      AnimatedSnackBar.material(
        'Login success'.tr,
        type: AnimatedSnackBarType.success,
      ).show(context);
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        'Login error'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    }
  }

  Future<void> _handleLogin(String token, BuildContext context) async {
    try {
      await AuthServices.setAuthBearerToken(token);
      await AuthServices.isAuthenticated();
      await _handleCurrentUser(context);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> _handleLoginWithFirebase(
    String firebaseToken,
    BuildContext context,
  ) async {
    try {
      final userCredential = await fbAuth.FirebaseAuth.instance
          .signInWithCustomToken(firebaseToken);

      fbAuth.User? user = userCredential.user;
      if (user != null) {
        final idToken = await user.getIdToken();
        await AuthServices.setAuthFirebaseToken(idToken);
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> _handleCurrentUser(BuildContext context) async {
    try {
      final apiResponse = await _userRequest.getCurrentUser();

      if (apiResponse.allGood) {
        await AuthServices.saveUser(apiResponse.body);
      } else {
        throw Exception(apiResponse.error);
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
