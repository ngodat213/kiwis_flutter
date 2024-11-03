import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import 'message_controller.dart';

class MessageView extends BaseView<MessageController> {
  MessageView({super.key});

  @override
  bool get isNavigationBar => true;

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Container(
          padding: EdgeInsets.all(24.h),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
            borderRadius: BorderRadiusStyle.roundedBorder24,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.svgMenuDefault,
                          height: 24.h,
                          width: 24.h,
                        ),
                        SizedBox(width: 24.h),
                        CustomImageView(
                          imagePath: ImageConstant.imgAvatar,
                          height: 40.h,
                          width: 40.h,
                          radius: BorderRadius.circular(
                            30.h,
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl_hello".tr,
                                style: theme.textTheme.labelLarge,
                              ),
                              Text(
                                "lbl_samms".tr,
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          // onTap: notificationOnPressed,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x0DFFFFFF),
                                borderRadius: BorderRadius.circular(100)),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.h,
                            ),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.svgBell,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SizedBox(width: 16.h),
                                Container(
                                  width: 24.h,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF1F41F4),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
