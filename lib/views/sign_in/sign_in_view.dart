import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/sign_in/sign_in_controller.dart';
import 'package:kiwis_flutter/views/sign_in/widgets/sign_in_content.dart';

// ignore: must_be_immutable
class SignInScreen extends BaseView<SignInController> {
  SignInScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return SignInContent(
      emailTxtController: controller.emailTxtController,
      passwordTxtController: controller.passwordTxtController,
      onSignInButtonPressed: controller.onSignInButtonPressed,
      onSignUpButtonPressed: controller.onSignUpButtonPressed,
      isShowPassword: controller.isShowPassword,
    );
  }
}
