import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/notification_center/notification_center_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class NotificationCenterScreen extends GetWidget<NotificationCenterController> {
  const NotificationCenterScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 798.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2006Green600,
                    height: 274.h,
                    width: 344.h,
                    alignment: Alignment.bottomLeft,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2005,
                    height: 280.h,
                    width: 274.h,
                    alignment: Alignment.topRight,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(),
                        ),
                        SizedBox(height: 16.h),
                        _buildNotificationList()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 52.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        margin: EdgeInsets.only(left: 8.h),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarTitle(
        text: "lbl_notification".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgList,
          margin: EdgeInsets.only(right: 8.h),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildNotificationList() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 12.h,
          );
        },
        itemCount: controller.notificationCenterModelObj.value
            .notificationlistItemList.value.length,
        itemBuilder: (context, index) {
          NotificationlistItemModel model = controller
              .notificationCenterModelObj
              .value
              .notificationlistItemList
              .value[index];
          return NotificationlistItemWidget(
            model,
          );
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
