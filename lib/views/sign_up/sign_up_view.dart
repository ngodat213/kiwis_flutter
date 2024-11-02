import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/sign_up/sign_up_controller.dart';
import 'package:kiwis_flutter/views/sign_up/widgets/sign_up_content.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends BaseView<SignUpController> {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget body(BuildContext context) {
    return SignUpContent(
      controller.emailInputController,
      controller.passwordInputController,
      controller.firstNameInputController,
      controller.lastNameInputController,
      controller.isShowPassword,
      controller.onSignUpButtonPressed,
    );
  }
}
