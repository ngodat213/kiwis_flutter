import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:camera/camera.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/post.model.dart';
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
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _cameraWidget(context);
              }
              return _postSection(controller.posts[index - 1]);
            },
            scrollDirection: Axis.vertical,
            itemCount: controller.posts.length + 1,
            loop: false,
            fade: 0.1,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(context),
          ),
        ],
      ),
    );
  }

  Widget _postSection(PostModel post) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: post.user?.avatar?.imageUrl ??
                          AppValues.defaultAvatar,
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
                            post.formatPostedAt(),
                            style: CustomTextStyles
                                .labelLargeGoogleSansMediumOnPrimary,
                          ),
                          Text(
                            "${post.user?.lastName} ${post.user?.firstName}",
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Container(
                            width: 40.h,
                            height: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Color(0x0DFFFFFF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.svgStar,
                              height: 40.h,
                              width: 40.h,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.h),
                          GestureDetector(
                            onTap: controller.detailPostOnPressed,
                            child: Container(
                              width: 40.h,
                              height: 40.h,
                              padding: EdgeInsets.all(8.h),
                              decoration: BoxDecoration(
                                color: Color(0x0DFFFFFF),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.svgArrowRight,
                                height: 40.h,
                                width: 40.h,
                                radius: BorderRadius.circular(
                                  30.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                Stack(
                  children: [
                    CustomImageView(
                      radius: BorderRadius.circular(12.h),
                      imagePath: post.images?.first.imageUrl ?? "",
                      height: Get.width - 72.h,
                      width: Get.width - 72.h,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 16.h,
                      right: 16.h,
                      child: Row(
                        children: [
                          Container(
                            width: 40.h,
                            height: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.svgHeart,
                              height: 40.h,
                              width: 40.h,
                              color: Colors.white,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Container(
                            width: 40.h,
                            height: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.svgComment,
                              height: 40.h,
                              width: 40.h,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  post.caption ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.labelLargeGoogleSansMedium.copyWith(
                    height: 1.67,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
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
                        CustomImageView(
                          imagePath: controller.user.value.avatar?.imageUrl ??
                              AppValues.defaultAvatar,
                          height: 40.h,
                          width: 40.h,
                          fit: BoxFit.cover,
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
                                "${controller.user.value.firstName}".tr,
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
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

  Widget _cameraWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.2),
        Stack(
          children: [
            // Camera Preview
            Obx(() {
              if (controller.onPost.value) {
                return Container(
                  height: Get.width - 70.h,
                  width: Get.width - 70.h,
                  child: Stack(
                    children: [
                      Container(
                        width: Get.width - 70.h,
                        height: Get.width - 70.h,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(controller.imageXFile.value.path),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: Get.width - 97.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.h),
                                child: TextField(
                                  controller: controller.captionTEC,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Enter text',
                                    hintStyle: TextStyle(color: Colors.white54),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).marginOnly(bottom: 16.h),
                    ],
                  ),
                );
              } else {
                if (controller.isCameraInitialized.value) {
                  return Container(
                    width: Get.width - 70.h,
                    height: Get.width - 70.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CameraPreview(controller.cameraController),
                    ),
                  );
                } else {
                  return Container(
                    width: Get.width - 70.h,
                    height: Get.width - 70.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }
              }
            }),
          ],
        ),
        SizedBox(height: 20.h),
        Obx(
          () {
            return controller.onPost.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 60.h,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: controller.closeOnPost,
                          ),
                        ),
                      ),
                      Container(
                        width: 60.h,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => controller.onPressedPost(context),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          controller.isFlashOn.value
                              ? Icons.flash_on
                              : Icons.flash_off,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: controller.toggleFlash,
                      ),
                      GestureDetector(
                        onTap: controller.takePicture,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: controller.toggleRotate,
                      ),
                    ],
                  );
          },
        )
      ],
    );
  }
}
