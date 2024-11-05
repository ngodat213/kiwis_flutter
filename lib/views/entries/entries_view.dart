import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';

import 'entries_controller.dart';

class EntriesView extends BaseView<EntriesController> {
  EntriesView({super.key});

  Widget? floatingActionButton(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.h,
            height: 32.h,
            child: Icon(
              IconlyBold.location,
              color: appTheme.blue300,
            ),
          ),
          Container(
            width: 32.h,
            height: 32.h,
            child: Icon(
              IconlyBold.camera,
              color: appTheme.blue300,
            ),
          ),
          SizedBox(width: 8.h),
          CustomTextFormField(
            height: Get.height * 0.06,
            width: Get.width * 0.7,
            hintText: "Message",
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconlyBold.send,
                  color: appTheme.blue300,
                ),
              ],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.h),
              borderSide: BorderSide(width: 0),
            ),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      width: double.maxFinite,
      margin: EdgeInsets.only(top: 32.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Stack(
        children: [
          SizedBox(height: 32.h),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
