import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/home/widgets/camera.wiget.dart';
import 'package:kiwis_flutter/views/home/widgets/post.item.dart';
import 'home_controller.dart';

class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  @override
  bool get isNavigationBar => true;

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      child: Stack(
        children: [
          Obx(() {
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return CameraWidget();
                }
                return PostItem(post: controller.posts[index - 1]);
              },
              scrollDirection: Axis.vertical,
              itemCount: controller.posts.length + 1,
              loop: false,
              fade: 0.1,
            );
          }),
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(context),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection(BuildContext context) {
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
                        GestureDetector(
                          onTap: () => controller.onPressedMenu(context),
                          child: CustomImageView(
                            imagePath: ImageConstant.svgMenuDefault,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ),
                        SizedBox(width: 24.h),
                        Obx(() {
                          return CustomImageView(
                            imagePath: controller.user.value.avatar?.imageUrl ??
                                AppValues.defaultAvatar,
                            height: 40.h,
                            width: 40.h,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(
                              30.h,
                            ),
                          );
                        }),
                        SizedBox(width: 16.h),
                        Obx(() {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "lbl_hello".tr,
                                  style: theme.textTheme.labelLarge,
                                ),
                                Text(
                                  "${controller.user.value.firstName ?? ''}".tr,
                                  style: theme.textTheme.titleLarge,
                                )
                              ],
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: controller.notificationOnPressed,
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
