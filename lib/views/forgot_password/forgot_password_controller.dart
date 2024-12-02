import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/views/forgot_password/widgets/otp.content.dart';

class ForgotPasswordController extends BaseController {
  final TextEditingController emailTEC = TextEditingController();
  final AuthRequest _authRequest = AuthRequest();

  @override
  void onInit() {
    emailTEC.text = kReleaseMode ? "" : "ngodat.it213@gmail.com";
    super.onInit();
  }

  Future<void> onPressedForgotPassword(BuildContext context) async {
    late ApiResponse apiResponse;
    try {
      apiResponse =
          await _authRequest.forgotPasswordRequest(email: emailTEC.text);
      if (apiResponse.allGood) {
        otpModal(context);
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        apiResponse.error!.tr,
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  void otpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => OtpContent(),
    );
  }
}
